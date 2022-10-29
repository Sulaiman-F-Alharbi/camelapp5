import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/HistoryItem.dart';
import 'CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import '../screens/GeneralInformations.dart';
import '../screens/History.dart';
import '../screens/TakePicture.dart';
import '../screens/statistics.dart';
import '../screens/AboutUs.dart';
import '../screens/HelpCenter.dart';
import '../screens/Home.dart';
import 'package:camelapp/screens/classificationResult.dart';
import 'package:camelapp/screens/Processing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart' as Path;
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);
var imageCounter = 0;

class MyHomePage extends StatefulWidget {
  static int CurrentTab = 0;
  static Widget currentScreen = Home();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const TextStyle _textStyle = TextStyle(
      color: Colors.black45, fontSize: 16, fontWeight: FontWeight.bold);

  //setup the history list
  late SharedPreferences prefs;
  List HistoryItems = [];

  //the name of the image's breed
  String breed = '';

  //the app is loading(after uplaoding the image go to loading screen)
  bool isProcessing = false;

  //new functions to upload images
  late File _photo;
  final ImagePicker _picker = ImagePicker();

  Future takeImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    //go to the loading page
    setState(() => isProcessing = true);

    var currentUser = await Amplify.Auth.getCurrentUser();

    //uplaod image to the model to identify
    await IdentifyImage(pickedFile);
    breed = breedToArabic(breed);
    //get the current time to use it as an image id for the history
    DateTime now = new DateTime.now();
    int id = Random(now.year +
            now.month +
            now.day +
            now.hour +
            now.minute +
            now.second +
            now.millisecond)
        .nextInt(1000);
    String imageName = now.toString() + ".jpg";
    print("==================" + imageName + "=======================");
    String date = "${now.year}-${now.month}-${now.day}";
    //add image and its information to the history list and save it locally
    HistoryItems.add(
        HistoryItem(id: id, breed: breed, date: date, image: imageName));
    saveHistory();
    saveImage(pickedFile, imageName);

    var userid = currentUser.userId;
    var uuid = const Uuid().v4();
    // Upload image with the current time as the key
    final key = "$userid/$uuid.jpg";
    final file = File(pickedFile.path);
    const snackBar = SnackBar(content: Text("uploaded"));
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: file,
        key: key,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar); //noti user the image is uploaded
      print('Successfully uploaded image: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading image: $e');
    }

    //go to the result page
    File? Image;
    Image = File(pickedFile.path);
    breed = breed;
    isProcessing = false;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Result(image: Image, breed: breed)));
  }

  //upload the image to the server and get the breed name
  IdentifyImage(pickedImage) async {
    File selectedImage = File(pickedImage.path);
    //change link
    final request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://ec2-3-82-108-159.compute-1.amazonaws.com:8080/predict"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage.readAsBytes().asStream(), selectedImage.lengthSync(),
        filename: selectedImage.path.split("/").last));

    request.headers.addAll(headers);
    print("request: " + request.toString());
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = await jsonDecode(res.body);
    breed = await resJson['message'];
    print("==================" + breed + "=======================");
    setState(() {});
  }

  //mab breed name to arabic
  breedToArabic(String breed) {
    if (breed == "Alhumr") {
      return breed = "حمراء";
    } else if (breed == "Alshaqh") {
      return breed = "شقحاء";
    } else if (breed == "Alshuel") {
      return breed = "شعل";
    } else if (breed == "Alsifr") {
      return breed = "صفراء";
    } else if (breed == "Alwadah") {
      return breed = "وضحاء";
    } else if (breed == "Mijaheem") {
      return breed = "مجاهيم";
    }
  }

  //to load the history list
  setupHistory() async {
    prefs = await SharedPreferences.getInstance();
    String? stringHistroy = prefs.getString('HistoryI');
    List HistoryList = jsonDecode(stringHistroy!);
    for (var HistoryI in HistoryList) {
      setState(() {
        HistoryItems.add(HistoryItem(breed: '', date: '', id: 0, image: '')
            .fromJson(HistoryI));
      });
    }
  }

  //save the new identified image in history
  void saveHistory() {
    List items = HistoryItems.map((e) => e.toJson()).toList();
    prefs.setString('HistoryI', jsonEncode(items));
  }

  //to call and setup the history list
  @override
  void initState() {
    super.initState();
    setupHistory();
  }

  //to save the image localy for later use
  void saveImage(XFile img, String fileName) async {
    // Step 3: Get directory where we can duplicate selected file.
    final String path = (await getApplicationDocumentsDirectory()).path;

    File convertedImg = File(img.path);

    // Step 4: Copy the file to a application document directory.
    // final fileName = basename(convertedImg.path);
    final File localImage = await convertedImg.copy('$path/$fileName');
    print("Saved image under: $path/$fileName");
  }
  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   print("================the directory: " +
  //       '${directory.path}' +
  //       "===================");
  //   final name = Path.basename(imagePath);
  //   final image = File('${directory.path}/$name');

  //   return File(imagePath).copy(image.path);
  // }

  final List<Widget> screens = [
    Home(),
    TakePicture(),
    Statistics(),
    const GetInfoWidget(),
    History(),
    HelpCenter(),
    AboutUs(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) => isProcessing
      ? Processing()
      : Scaffold(
          extendBody: true,

          //the top appbar with the logo
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(152, 78, 51, 1),
            iconTheme: IconThemeData(color: Colors.black),
            toolbarHeight: 60,
            centerTitle: true,
            title: Image.asset(
              'assets/images/camelicon.png',
              fit: BoxFit.contain,
              height: 65,
              width: 65,
              alignment: Alignment.center,
            ),
          ),
          //call the drawer
          endDrawer: CustomEndDrawer(),

          body: PageStorage(
            child: MyHomePage.currentScreen,
            bucket: bucket,
          ),
          //camera button in the middle
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              cameraPopUp(context);
            },
            backgroundColor: Color.fromRGBO(152, 78, 51, 1),
            elevation: 30,
          ),

          //creating the bottom app bar
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: Color.fromRGBO(152, 78, 51, 1),
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Left hand icons (Home and Statistics)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //General Information
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            MyHomePage.currentScreen = GetInfoWidget();
                            MyHomePage.CurrentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //create icon
                            Icon(
                              MyHomePage.CurrentTab == 3
                                  ? Icons.info
                                  : Icons.info_outlined,
                              size: 35,
                            ),
                            //the label of the icon
                            const Text(
                              'أنواع الإبل',
                              style: TextStyle(
                                fontFamily: 'DINNextLTArabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Statistics Button
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            MyHomePage.currentScreen = Statistics();
                            MyHomePage.CurrentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyHomePage.CurrentTab == 1
                                  ? Icons.analytics
                                  : Icons.analytics_outlined,
                              size: 35,
                            ),
                            const Text(
                              'الإحصائيات',
                              style: TextStyle(
                                fontFamily: 'DINNextLTArabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Right hand icons (History and General Information)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //History button
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            MyHomePage.currentScreen = History();
                            MyHomePage.CurrentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyHomePage.CurrentTab == 2
                                  ? Icons.history
                                  : Icons.history_outlined,
                              size: 35,
                            ),
                            const Text(
                              'السجل',
                              style: TextStyle(
                                fontFamily: 'DINNextLTArabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Home button
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            MyHomePage.currentScreen = Home();
                            MyHomePage.CurrentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyHomePage.CurrentTab == 0
                                  ? Icons.home
                                  : Icons.home_outlined,
                              size: 35,
                            ),
                            const Text(
                              'الرئيسية',
                              style: TextStyle(
                                fontFamily: 'DINNextLTArabic',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

  void cameraPopUp(context) {
    var backgroundColor = Color.fromRGBO(173, 222, 254, 0.6);
    var buttonsColor = Color.fromRGBO(204, 123, 76, 1);

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: backgroundColor,
                ),
                child: Column(children: [
                  const Text(
                    'رفع صورة',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buttonsColor,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      //open the camera on press to take a picture
                      onPressed: () {
                        takeImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'من الكاميرا',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'DINNextLTArabic',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buttonsColor,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        takeImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'من ألبوم الصور',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'DINNextLTArabic',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel,
                      size: 40,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ]),
              ),
            ),
          );
        });
  }
}

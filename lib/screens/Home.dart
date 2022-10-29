import 'dart:ui';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:camelapp/widgets/BottomNavigator.dart';
import 'classificationResult.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Processing.dart';
// import 'package:in_app_notification/in_app_notification.dart';

// import 'package:camelapp/widgets/Loading.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:camelapp/services/HistoryItem.dart';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;

import 'dart:io';

import 'package:uuid/uuid.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Processing()),
      );
    });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //Background Image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background6.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.0))),
            ),
          ),
          Container(
            //welcoming messege and a start button
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'مرحبا بك في تطبيق\nجملي',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'يتيح لك التطبيق التعرف على\nنوع الجمال بواسطة الصور',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  //Take an image button
                  const SizedBox(height: 50),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(142, 99, 83, 0.8),
                      ),
                      width: 200,
                      height: 190,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () {
                          cameraPopUp(context);
                        },
                        child: Column(
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const <Widget>[
                            Icon(
                              Icons.camera_alt,
                              size: 35,
                              textDirection: TextDirection.rtl,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "اضغط هنا للتعرف على نوع الجمل",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'DINNextLTArabic',
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void cameraPopUp(context) {
    var backgroundColor = Color.fromRGBO(173, 222, 254, 0.4);
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

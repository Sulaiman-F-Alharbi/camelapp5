import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'classificationResult.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Processing.dart';
// import 'package:in_app_notification/in_app_notification.dart';

// import 'package:camelapp/widgets/Loading.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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

  //the name of the image's breed
  String breed = '';

  //the app is loading(after uplaoding the image go to loading screen)
  bool isProcessing = false;

  //new functions to upload images
  late File _photo;
  final ImagePicker _picker = ImagePicker();

  Future takeImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    var currentUser = await Amplify.Auth.getCurrentUser();
    if (pickedFile == null) {
      print('No image selected');
      return;
    }
    if (pickedFile == null) {
      print('No image selected');
      return;
    }

    //to save the Image permenently and locally on device
    // final imagePermanent = await saveImagePermanently(pickedFile.path);

    //go to the loading page
    setState(() => isProcessing = true);

    //uplaod image to the model to identify
    await IdentifyImage(pickedFile);

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

  IdentifyImage(pickedImage) async {
    File selectedImage = File(pickedImage.path);
    //change link
    final request = http.MultipartRequest(
        'POST', Uri.parse("http://9756-34-73-205-207.ngrok.io/predict"));
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

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   print("================the directory: " +
  //       '${directory.path}' +
  //       "===================");
  //   final name = Path.basename(imagePath);
  //   final image = File('${directory.path}/$name');

  //   return File(imagePath).copy(image.path);
  // }

//////////////////////////////////

  // Future uploadFile() async {
  //   if (_photo == null) return;
  //   final fileName = basename(_photo!.path);
  //   const destination = 'files/';
  //   var imageCounter = navigator.imageCounter;
  //   try {
  //     final ref = firebase_storage.FirebaseStorage.instance
  //         .ref(destination)
  //         .child('image$imageCounter');
  //     navigator.imageCounter++;
  //     await ref.putFile(_photo!);
  //   } catch (e) {
  //     print('error occured');
  //   }
  // }
  @override
  Widget build(BuildContext context) => isProcessing
      ? Processing()
      : Scaffold(
          backgroundColor: Mainbeige,
          body: Container(
            //Background Image
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background6.jpg"),
                fit: BoxFit.cover,
              ),
            ),
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
        );

  void cameraPopUp(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Mainbrown,
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
                  color: Mainbeige,
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
                  color: Mainbeige,
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
          );
        });
  }
}

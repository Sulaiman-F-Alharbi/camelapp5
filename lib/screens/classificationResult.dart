import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:camelapp/widgets/BottomNavigator.dart';
import 'GeneralInformations.dart';
import 'Home.dart';
import 'package:camelapp/widgets/CustomEndDrawer.dart';
import 'dart:io';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.image,
    required this.breed,
  }) : super(key: key);

  final File? image;
  final String breed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbrown,
      //Top bar with the logo
      //Background Image
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(
                  image: FileImage(image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "${breed}",
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'DINNextLTArabic',
                fontWeight: FontWeight.w600,
                color: gettextColor(),
              ),
              textAlign: TextAlign.center,
            ),

            //navigation buttons
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white.withOpacity(0.5),
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    MaterialButton(
                        height: 58,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          MyHomePage.CurrentTab = 0;
                          MyHomePage.currentScreen = Home();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyHomePage()),
                          );
                        },
                        child: const Text(
                          "العودة إلى \nالصفحة الرئيسية",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'DINNextLTArabic',
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                    const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    MaterialButton(
                        height: 48,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          MyHomePage.CurrentTab = 3;
                          MyHomePage.currentScreen = GetInfoWidget();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    MyHomePage()),
                          );
                        },
                        child: const Text(
                          "معرفة المزيد \nعن نوع الجمل",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'DINNextLTArabic',
                              color: Colors.black),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            )

            // child: Center(
            //   child: Column(
            //     children: [
            //       SizedBox(height: 20),
            //       Container(
            //         child: Text(
            //           "${breed}",
            //           style: TextStyle(
            //             fontSize: 35,
            //             fontFamily: 'DINNextLTArabic',
            //             fontWeight: FontWeight.w600,
            //             color: gettextColor(),
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //       SizedBox(height: 20),
            //       //image result
            //       Stack(
            //         children: [
            //           Container(
            //             height: 350,
            //             width: 250,
            //             decoration: BoxDecoration(
            //               borderRadius: const BorderRadius.all(Radius.circular(20)),
            //               color: Colors.blue,
            //             ),
            //             child: Align(
            //               alignment: Alignment(0, 0.9),
            //               child: Text(
            //                 'hey',
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             height: 300,
            //             width: 250,
            //             decoration: BoxDecoration(
            //               borderRadius: const BorderRadius.all(Radius.circular(20)),
            //               image: DecorationImage(
            //                 image: FileImage(image!),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       //breed type
            //       Text(
            //         "نوع الجمل: " + breed,
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontFamily: 'DINNextLTArabic',
            //             color: Colors.black),
            //         textAlign: TextAlign.right,
            //       ),
            //       //go back button
            //       Card(
            //         color: Mainbrown,
            //         child: TextButton(
            //             onPressed: () {
            //               MyHomePage.CurrentTab = 0;
            //               MyHomePage.currentScreen = Home();
            //               Navigator.pushReplacement(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (BuildContext context) => MyHomePage()),
            //               );
            //             },
            //             child: const Text(
            //               "العودة للصفحة الرئيسية",
            //               style: TextStyle(
            //                   fontSize: 20,
            //                   fontFamily: 'DINNextLTArabic',
            //                   color: Colors.black),
            //               textAlign: TextAlign.right,
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  gettextColor() {
    if (breed == "حمر") {
      return Colors.red;
    } else if (breed == "شقح") {
      return;
    } else if (breed == "شعل") {
      return;
    } else if (breed == "صفر") {
      return Colors.yellow;
    } else if (breed == "وضح") {
      return Colors.white;
    } else if (breed == "مجاهيم") {
      return Colors.black;
    }
  }
}

import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:camelapp/widgets/BottomNavigator.dart';
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
      backgroundColor: Mainbeige,
      //Top bar with the logo
      appBar: AppBar(
        backgroundColor: Mainbrown,
        iconTheme: const IconThemeData(color: Colors.black),
        toolbarHeight: 60,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo.png',
          fit: BoxFit.contain,
          height: 70,
          width: 70,
          alignment: Alignment.center,
        ),
      ),
      endDrawer: CustomEndDrawer(),
      body: Center(
        child: Column(
          children: [
            Card(
              child: Image.file(image!),
            ),
            Text(
              "نوع الجمل: " + breed,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'DINNextLTArabic',
                  color: Colors.black),
              textAlign: TextAlign.right,
            ),
            Card(
              color: Mainbrown,
              child: TextButton(
                  onPressed: () {
                    MyHomePage.CurrentTab = 0;
                    MyHomePage.currentScreen = Home();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()),
                    );
                  },
                  child: const Text(
                    "العودة للصفحة الرئيسية",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'DINNextLTArabic',
                        color: Colors.black),
                    textAlign: TextAlign.right,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

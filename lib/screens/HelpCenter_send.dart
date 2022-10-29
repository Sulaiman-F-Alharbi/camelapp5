import 'dart:ui';

import 'Home.dart';
import '../Widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import '../widgets/BottomNavigator.dart';

// const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbrown = const Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class HelpCenter2 extends StatefulWidget {
  const HelpCenter2({super.key});

  @override
  State<HelpCenter2> createState() => _HelpCenter2State();
}

class _HelpCenter2State extends State<HelpCenter2> {
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
          'assets/images/camelicon.png',
          fit: BoxFit.contain,
          height: 65,
          width: 65,
          alignment: Alignment.center,
        ),
      ),
      endDrawer: CustomEndDrawer(),
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
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: new Container(
                  decoration:
                      new BoxDecoration(color: Colors.white.withOpacity(0.0))),
            ),
          ),
          Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/background6.jpg"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                  const SizedBox(height: 50),
                  const Text(
                    'شكراً لك \nسيتم حل المشكة في أقرب وقت ممكن',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Color.fromRGBO(217, 165, 115, 1),
                    child: TextButton(
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
                          "العودة للصفحة الرئيسية",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'DINNextLTArabic',
                              color: Colors.black),
                          textAlign: TextAlign.right,
                        )),
                  )
                ])),
          ),
        ],
      ),
    );
  }
}

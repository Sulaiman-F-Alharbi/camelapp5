import 'dart:ui';

import 'package:flutter/material.dart';
import '../services/AuthService.dart';

import '../screens/AboutUs.dart';
import 'BottomNavigator.dart';
import '../screens/GeneralInformations.dart';
import '../screens/HelpCenter.dart';
import '../screens/History.dart';
import '../screens/TakePicture.dart';
import '../screens/statistics.dart';

const Mainbrown = Color.fromRGBO(137, 115, 88, 1);
const tileColor = Color.fromRGBO(204, 123, 76, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // creating a drawer(hamburger menu)
        ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Drawer(
          elevation: 30,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
          ),
          backgroundColor: //Color.fromRGBO(152, 78, 51,0.5), //Color.fromRGBO(204, 123, 76, 1),
              Color.fromRGBO(173, 222, 254, 0.4),
          child: ListView(
            children: <Widget>[
              //identfy camel option (class takePicture)
              SizedBox(height: 30),
              //view Statistics page (class statistics)
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  tileColor: tileColor,
                  //Color.fromRGBO(152, 78, 51, 1),
                  trailing: const Icon(
                    Icons.analytics,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: const Text(
                    "الإحصائيات",
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'DINNextLTArabic'),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    MyHomePage.CurrentTab = 1;
                    MyHomePage.currentScreen = Statistics();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()),
                    );
                  },
                ),
              ),
              //view general camel information page
              SizedBox(height: 5),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  tileColor: tileColor,
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  //creating the icon
                  trailing: const Icon(
                    Icons.info,
                    color: Colors.black,
                    size: 35,
                  ),
                  //title of the icon
                  title: const Text(
                    "معلومات عامة عن الإبل",
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'DINNextLTArabic'),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    MyHomePage.CurrentTab = 3;
                    MyHomePage.currentScreen = GetInfoWidget();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()),
                    );
                  },
                ),
              ),
              //View History page
              SizedBox(height: 5),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  tileColor: tileColor,
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  trailing: const Icon(
                    Icons.history,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: const Text(
                    "السجل",
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'DINNextLTArabic'),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    MyHomePage.CurrentTab = 2;
                    MyHomePage.currentScreen = History();
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomePage()),
                    );
                  },
                ),
              ),
              //View Help Center page
              SizedBox(height: 5),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  tileColor: tileColor,
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  trailing: const Icon(
                    Icons.help,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: const Text(
                    "المساعدة",
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'DINNextLTArabic'),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const HelpCenter()),
                    );
                  },
                ),
              ),
              // View About us page
              SizedBox(height: 5),
              Card(
                elevation: 0,
                color: Colors.transparent,
                child: ListTile(
                  tileColor: tileColor,
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  trailing: const Icon(
                    Icons.group,
                    color: Colors.black,
                    size: 35,
                  ),
                  title: const Text(
                    "من نحن",
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'DINNextLTArabic'),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const AboutUs()),
                    );
                  },
                ),
              ),

              const SizedBox(height: 270),
              Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: ListTile(
                  tileColor: tileColor,
                  minVerticalPadding: 10,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.logout,
                    color: Color(0xFFC72c41),
                    size: 35,
                  ),
                  title: const Text(
                    "تسجيل الخروج",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'DINNextLTArabic',
                      color: Color(0xFFC72c41),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () async {
                    AuthService().signOut(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

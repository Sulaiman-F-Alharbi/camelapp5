import 'package:flutter/material.dart';

import '../widgets/CustomEndDrawer.dart';

final Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
final Mainbeige = const Color.fromRGBO(230, 203, 160, 1);

class TakePicture extends StatefulWidget {
  const TakePicture({super.key});

  @override
  State<TakePicture> createState() => _TakepicState();
}

class _TakepicState extends State<TakePicture> {
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
          height: 70,
          width: 70,
          alignment: Alignment.center,
        ),
      ),

      endDrawer: const CustomEndDrawer(),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background6.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Mainbrown,
            ),
            width: 200,
            height: 200,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () {
                _CameraPopup(context);
              },
              child: Column(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: const <Widget>[
                  Icon(
                    Icons.camera_alt,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    'اختيار صورة',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'اضغط هنا\nلتحديد الصورة',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'DINNextLTArabic',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      //Making the bottom bar to navigate (navigationBar)
    );
  }

  void _CameraPopup(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
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
                  onPressed: () {
                    _CameraPopup(context);
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
                    _CameraPopup(context);
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

// class CustomBottomBar extends StatelessWidget {
//   const CustomBottomBar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       backgroundColor: Mainbrown,
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.black,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           activeIcon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.camera_alt_outlined),
//           activeIcon: Icon(Icons.camera_alt),
//           label: 'Camera',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.arrow_back_ios_new_outlined),
//           activeIcon: Icon(Icons.arrow_back_ios_new),
//           label: 'Back',
//         ),
//       ],
//     );
//   }
// }
import '../Widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,

      //The top bar
      appBar: AppBar(
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
      endDrawer: CustomEndDrawer(),
      //About us text
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: const [
            SizedBox(height: 50),
            Align(
              alignment: Alignment(0.6, 0),
              child: Text(
                'تم صنع هذا التطبيق\n من قبل:',
                style: TextStyle(
                  fontSize: 31,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment(0.6, 0),
              child: Text(
                '1-نواف الخلف\n2-سليمان الحربي\n3-عبدالعزيز الصديق\n4-عبدالعزيز الحصيني',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'DINNextLTArabic',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

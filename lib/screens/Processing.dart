import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Processing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbrown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'جاري المعالجة',
              style: TextStyle(
                fontSize: 35,
                fontFamily: 'DINNextLTArabic',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50),
            SpinKitRing(
              size: 100,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

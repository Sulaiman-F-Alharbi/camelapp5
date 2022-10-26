import 'package:flutter/material.dart';
import '../services/AuthService.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class ConfirmationPage extends StatefulWidget {
  final username;
  ConfirmationPage({this.username});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late String code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbrown,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.all(8.0),
              height: 300.0,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'رمز التحقق',
                      hintTextDirection: TextDirection.rtl),
                  onChanged: (val) {
                    setState(() {
                      code = val;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(152, 78, 51, 1),
                    ),
                    onPressed: () {
                      AuthService().confirmUser(widget.username, code, context);
                    },
                    child: Text('تأكيد'))
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'HelpCenter_send.dart';
import '../Widgets/CustomEndDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';

// const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbrown = const Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);
final scaffoldKey = GlobalKey<ScaffoldState>();

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenter();
}

class _HelpCenter extends State<HelpCenter> {
  final _key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  //send email to emailJS
  sendEmail(String name, String email, String subject, String message) async {
    final serviceId = 'service_1vr7qm9';
    final templateId = 'template_bmu8w4y';
    final userId = 'LxHIDFywRftU8rpwj';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 66, 30, 14),
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
        endDrawer: const CustomEndDrawer(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage("assets/images/background6.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: Form(
                  key: _key,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'بريدك الإلكتروني*',
                                hintTextDirection: TextDirection.rtl,
                                fillColor: Colors.blue),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء كتابة بريدك الإلكتروني';
                              }
                              return null;
                            },
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            controller: subject,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'العنوان',
                                hintTextDirection: TextDirection.rtl,
                                fillColor: Colors.blue),
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            controller: body,
                            maxLines: 8,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'أكتب المشكلة التي تعاني منها*',
                                hintTextDirection: TextDirection.rtl,
                                fillColor: Colors.blue),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء كتابةالمشكلة التي تعاني منها';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 25),
                        Card(
                          color: Color.fromRGBO(221, 212, 208, 0.5),
                          child: TextButton(
                              onPressed: () async {
                                _key.currentState!.save();
                                if (_key.currentState!.validate()) {
                                  var currentUser =
                                      await Amplify.Auth.getCurrentUser();
                                  sendEmail(currentUser.username, email.text,
                                      subject.text, body.text);

                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const HelpCenter2()),
                                  );
                                }
                              },
                              child: const Text(
                                "إرسال",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'DINNextLTArabic',
                                    color: Colors.black),
                                textAlign: TextAlign.right,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )));
  }
}

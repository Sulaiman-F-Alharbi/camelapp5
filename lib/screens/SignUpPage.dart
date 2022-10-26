import 'loginPage.dart';
import '../services/AuthService.dart';
import 'package:flutter/material.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String username, password, email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 161, 86, 6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(152, 78, 51, 1),
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
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background6.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white.withOpacity(0.5),
                padding: const EdgeInsets.all(8.0),
                height: 300.0,
                width: MediaQuery.of(context).size.width - 30,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'اسم المستخدم',
                          hintTextDirection: TextDirection.rtl),
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'الإيميل',
                          hintTextDirection: TextDirection.rtl),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'كلمة المرور',
                          hintTextDirection: TextDirection.rtl),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(152, 78, 51, 1)),
                        // const Color.fromARGB(255, 66, 53, 38)),
                        onPressed: () {
                          AuthService()
                              .signUp(email, username, password, context);
                        },
                        child: const Center(
                          child: Text('تسجيل'),
                        )),
                    const SizedBox(height: 10.0),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                        },
                        child: const Center(
                          child: Text(
                            'لدي حساب بالفعل',
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -7))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 3,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

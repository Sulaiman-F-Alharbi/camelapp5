import 'loginPage.dart';
import '../services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:camelapp/widgets/ErrorContainer.dart';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // late String username, password, email;

  TextEditingController passDumy = TextEditingController();
  TextEditingController usernameDumy = TextEditingController();
  TextEditingController email = TextEditingController();

  //to make password visiable or not dynamicly
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 66, 30, 14),
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background6.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Form(
                key: _key,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      height: 400.0,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: usernameDumy,
                            decoration: const InputDecoration(
                                hintText: 'اسم المستخدم',
                                hintTextDirection: TextDirection.rtl),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء كتابة إسم المستخدم';
                              }
                              return null;
                            },
                            // onChanged: (val) {
                            //   setState(() {
                            //     username = val;
                            //   });
                            // },
                          ),
                          TextFormField(
                            controller: email,
                            decoration: const InputDecoration(
                                hintText: 'البريد الإلكتروني',
                                hintTextDirection: TextDirection.rtl),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء كتابة البريد الإلكتروني';
                              }
                              return null;
                            },
                            // onChanged: (val) {
                            //   setState(() {
                            //     email = val;
                            //   });
                            // },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            controller: passDumy,
                            obscureText:
                                !_passwordVisible, //This will obscure text dynamically
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور',
                              hintTextDirection: TextDirection.rtl,
                              // hide password Icon
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            //show a red line if text field is empty
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'الرجاء كتابة كلمة المرور';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(152, 78, 51, 1)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                              // const Color.fromARGB(255, 66, 53, 38)),
                              onPressed: () {
                                _key.currentState!.validate();
                                if (passDumy.text == "" ||
                                    usernameDumy.text == "" ||
                                    email.text == "") {
                                  ErrorConatiner().getContainer(
                                      "أكمل الحقول المطلوبة", context);
                                }
                                AuthService().signUp(email.text,
                                    usernameDumy.text, passDumy.text, context);
                              },
                              child: const Center(
                                child: Text('تسجيل'),
                              )),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                              child: const Text('لدي حساب بالفعل',
                                  style: TextStyle(color: Mainbrown)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

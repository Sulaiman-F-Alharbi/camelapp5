import 'package:camelapp/screens/loginPage.dart';

import 'SignUpPage.dart';
import '../services/provider.dart';
import '../services/AuthService.dart';
import '../screens/splash.dart';
import 'package:camelapp/widgets/ErrorContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class ChangePassword extends StatefulHookWidget {
  // const ChangePassword({super.key});

  const ChangePassword({
    Key? key,
    required this.usernameDumy,
  }) : super(key: key);
  final TextEditingController usernameDumy;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // late String username, password;
  late bool userSignedIn;
  TextEditingController passDumy = TextEditingController();
  TextEditingController confirmPassDumy = TextEditingController();
  TextEditingController verificatoinCode = TextEditingController();

  TextEditingController test = TextEditingController();
  final _key = GlobalKey<FormState>();

  late String ErrorMessage;

  //to make password visiable or not dynamicly
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;
  @override
  void initState() {
    _passwordVisible = false;
    _passwordVisible2 = false;
  }

  @override
  Widget build(BuildContext context) {
    userSignedIn = UserLoggedIn().getUserCurrentState();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Center(
        child: Container(
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
                  height: 400,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: verificatoinCode,
                        decoration: const InputDecoration(
                            hintText: 'رمز التحقق',
                            hintTextDirection: TextDirection.rtl),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء كتابة إسم المستخدم';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        controller: passDumy,
                        obscureText:
                            !_passwordVisible, //This will obscure text dynamically
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور الجديدة',
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
                      TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        controller: confirmPassDumy,
                        obscureText:
                            !_passwordVisible2, //This will obscure text dynamically
                        decoration: InputDecoration(
                          hintText: 'تأكيد كلمة المرور',
                          hintTextDirection: TextDirection.rtl,
                          // hide password Icon
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(152, 78, 51, 1)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          onPressed: () async {
                            _key.currentState!.save();
                            if (passDumy.text == "" ||
                                confirmPassDumy.text == "" ||
                                verificatoinCode.text == "") {
                              ErrorConatiner().getContainer(
                                  "أكمل الحقول المطلوبة", context);
                            }
                            if (passDumy.text != confirmPassDumy.text) {
                              ErrorConatiner().getContainer(
                                  'فضلاً تأكد من تطابق كلمة المرور', context);
                              return;
                            }
                            ErrorMessage = await AuthService()
                                .confirmRecoverPassword(
                                    widget.usernameDumy.text,
                                    passDumy.text,
                                    verificatoinCode.text);
                            print("================" +
                                ErrorMessage +
                                "==============");
                            if (ErrorMessage != '') {
                              await ErrorConatiner()
                                  .getContainer(ErrorMessage, context);
                              // setState(() {
                              //   ErrorMessage = '';
                              // });
                              return;
                            }

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                          },
                          child: const Center(
                            child: Text(
                              'تأكيد',
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginPage()));
                        },
                        child: const Text('الرجوع إلى تسجيل الدخول',
                            style: TextStyle(color: Mainbrown)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

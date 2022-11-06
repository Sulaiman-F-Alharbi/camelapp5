import 'SignUpPage.dart';
import '../services/provider.dart';
import '../services/AuthService.dart';
import '../screens/splash.dart';
import 'package:camelapp/widgets/ErrorContainer.dart';
import 'RecoverPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class LoginPage extends StatefulHookWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // late String username, password;
  late bool userSignedIn;
  TextEditingController passDumy = TextEditingController();
  TextEditingController usernameDumy = TextEditingController();

  final _key = GlobalKey<FormState>();

  late String ErrorMessage;

  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    userSignedIn = UserLoggedIn().getUserCurrentState();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 66, 30, 14),
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
                      height: 350,
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
                                hintText: 'إسم المستخدم',
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
                              onPressed: () async {
                                _key.currentState!.save();
                                if (passDumy.text == "" ||
                                    usernameDumy.text == "") {
                                  ErrorConatiner().getContainer(
                                      "أكمل الحقول المطلوبة", context);
                                } else if (userSignedIn == true) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const Splash()));
                                } else {
                                  ErrorMessage = await AuthService().signIn(
                                      usernameDumy.text,
                                      passDumy.text,
                                      context);

                                  if (ErrorMessage != "") {
                                    ErrorConatiner()
                                        .getContainer(ErrorMessage, context);
                                  }
                                }
                              },
                              child: const Center(
                                child: Text(
                                  'تسجيل الدخول',
                                ),
                              )),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            textDirection: TextDirection.rtl,
                            children: [
                              Text(
                                'ليس لديك حساب؟',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpPage()));
                                },
                                child: const Text('تسجيل جديد',
                                    style: TextStyle(color: Mainbrown)),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      RecoverPassword()));
                            },
                            child: const Text('إسترجاع كلمة المرور؟',
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
        ));
  }
}

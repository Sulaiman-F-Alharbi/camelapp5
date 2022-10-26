import 'SignUpPage.dart';
import '../services/provider.dart';
import '../services/AuthService.dart';
import '../screens/splash.dart';
import 'package:camelapp/widgets/ErrorContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'ChangePassword.dart';

const Mainbrown = Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class RecoverPassword extends StatefulHookWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  // late String username, password;
  late bool userSignedIn;
  TextEditingController passDumy = TextEditingController();
  TextEditingController usernameDumy = TextEditingController();

  TextEditingController test = TextEditingController();
  final _key = GlobalKey<FormState>();

  late String ErrorMessage;

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
                  height: 300,
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
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(152, 78, 51, 1),
                          ),
                          onPressed: () async {
                            _key.currentState!.validate();
                            await AuthService()
                                .RecoverPassword(usernameDumy.text);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (_) => ChangePassword(
                                        usernameDumy: usernameDumy)));
                          },
                          child: const Center(
                            child: Text(
                              'التالي',
                              style: TextStyle(fontSize: 18),
                            ),
                          )),
                      const SizedBox(height: 10.0),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                          },
                          child: const Center(
                            child: Text(
                              'ليس لدي حساب',
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
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
      ),
    );
  }
}

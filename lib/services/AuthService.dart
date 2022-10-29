import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../screens/confirmationPage.dart';
import '../screens/loginPage.dart';
import '../screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../services/provider.dart';
import 'package:basic_utils/basic_utils.dart';

class AuthService {
  String ErrorMessege = "";

  signUp(email, username, password, context) async {
    try {
      var userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email
      };
      Amplify.Auth.signUp(
              username: username,
              password: password,
              options: CognitoSignUpOptions(userAttributes: userAttributes))
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => ConfirmationPage(
                    username: username,
                  )))));
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  //confirm user
  confirmUser(username, confirmationCode, context) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);
      if (res.isSignUpComplete) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  //Sign In
  signIn(username, password, context) async {
    try {
      SignInResult res =
          await Amplify.Auth.signIn(username: username, password: password);
      if (res.isSignedIn) {
        UserLoggedIn().setUserCurrentState(true);
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Splash()));
      }
    } on AuthException catch (e) {
      print(e.message);
      signinErrorMess(e.message);
      return ErrorMessege;
    }
  }

  //sign out
  signOut(context) async {
    SignOutResult res = await Amplify.Auth.signOut();
    UserLoggedIn().setUserCurrentState(false);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  RecoverPassword(username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      // setState(() {
      //   isPasswordReset = result.isPasswordReset;
      // });
      return ErrorMessege;
    } on AmplifyException catch (e) {
      safePrint(e);
      print("++++++++++++" + e.message + "+++++++++");
      RecoverPasswordErrorMess(e.message);
      return ErrorMessege;
    }
  }

  confirmRecoverPassword(username, newPassword, confirmationCode) async {
    try {
      await Amplify.Auth.confirmResetPassword(
          username: username,
          newPassword: newPassword,
          confirmationCode: confirmationCode);
      return ErrorMessege;
    } on AmplifyException catch (e) {
      print(e);
      print("=========" + e.message + "==============");
      ConfirmPasswordErrorMess(e.message);
      return ErrorMessege;
    }
  }

  signinErrorMess(String e) {
    if ("Failed since user is not authorized." == e) {
      return ErrorMessege = "كلمة المرور المدخلة خاطئة";
    } else if ("User not found in the system." == e) {
      return ErrorMessege = "إسم المستخدم المدخل خاطئ";
    }
    return ErrorMessege = "المعلومات المدخلة خاطئة";
  }

  RecoverPasswordErrorMess(String e) {
    if ("One or more parameters are incorrect." == e ||
        "User not found in the system." == e) {
      return ErrorMessege = "إسم المستخدم المدخل خاطئ";
    }
    if ("Number of allowed operation has exceeded." == e) {
      return ErrorMessege =
          "تجاوزت عدد المحاولات المسموحة يرجى المحاولة لاحقاً";
    } else {
      return ErrorMessege = "المعلومات المدخلة خاطئة";
    }
  }

  confirmCodeErrorMess(String e) {
    if ("Confirmation code entered is not correct." == e) {
      return ErrorMessege = "رمز التحقق المدخل خاطئ";
    }
    return ErrorMessege = "حدث خطأ يرجى المحاولة لاحقاً";
  }

  ConfirmPasswordErrorMess(String e) {
    if ("Confirmation code entered is not correct." == e) {
      return ErrorMessege = "رمز التحقق المدخل خاطئ";
    }
    if ("Number of allowed operation has exceeded." == e) {
      return ErrorMessege =
          "تجاوزت عدد المحاولات المسموحة يرجى المحاولة لاحقاً";
    } else {
      return ErrorMessege = "المعلومات المدخلة خاطئة";
    }
  }
}

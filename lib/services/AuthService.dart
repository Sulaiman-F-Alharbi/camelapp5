import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import '../screens/confirmationPage.dart';
import '../screens/loginPage.dart';
import '../screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../services/provider.dart';
import 'package:basic_utils/basic_utils.dart';

class AuthService {
  late String SignInMessege;

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
            .push(MaterialPageRoute(builder: (context) => Splash()));
      }
    } on AuthException catch (e) {
      print(e.message);
      print(signinErrorMess(e.message));
      print(SignInMessege);
      return SignInMessege;
    }
  }

  //sign out
  signOut(context) async {
    SignOutResult res = await Amplify.Auth.signOut();
    UserLoggedIn().setUserCurrentState(false);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  RecoverPassword(username) async {
    try {
      final result = await Amplify.Auth.resetPassword(
        username: username,
      );
      // setState(() {
      //   isPasswordReset = result.isPasswordReset;
      // });
    } on AmplifyException catch (e) {
      safePrint(e);
    }
  }

  confirmRecoverPassword(username, newPassword, confirmationCode) async {
    try {
      await Amplify.Auth.confirmResetPassword(
          username: username,
          newPassword: newPassword,
          confirmationCode: confirmationCode);
    } on AmplifyException catch (e) {
      print(e);
    }
  }

  signinErrorMess(String e) {
    if ("Failed since user is not authorized." == e) {
      return SignInMessege = "كلمة السر خاطئة";
    } else if ("User not found in the system." == e) {
      return SignInMessege = "اسم المستخدم خاطئ";
    }
    return SignInMessege = "المعلومات المدخلة خاطئة";
  }
}

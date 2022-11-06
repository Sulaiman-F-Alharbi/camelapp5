import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

import 'screens/Loading.dart';
import 'screens/loginPage.dart';
import 'services/provider.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'amplifyconfiguration.dart';
import 'screens/splash.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

const Mainbrown = Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = Color.fromRGBO(255, 240, 199, 1);

class MyApp extends StatefulHookWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool amplifyConfigured = false;
  bool checkAuthStatus = false;
  bool isSignedin = UserLoggedIn().getUserCurrentState();

  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  Future<void> configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    try {
      Amplify.addPlugins([auth, storage]);

      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print('Already configured');
    }
    try {
      await getUserStatus();
      setState(() {
        amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: displayPage()),
    );
  }

  displayPage() {
    if (amplifyConfigured == true) {
      if (checkAuthStatus == true) {
        if (isSignedin == true) {
          print("all true");
          return Splash();
        } else {
          print("user is signout 1");
          return LoginPage();
        }
      } else {
        print("check auth false");
        return LoadingPage();
      }
    } else {
      print("All false");
      return LoadingPage();
    }
  }

  getUserStatus() async {
    var authStatus = await Amplify.Auth.fetchAuthSession();

    if (authStatus.isSignedIn) {
      print("auth state1:${authStatus.isSignedIn}");
      setState(() {
        UserLoggedIn().isUserSignedIn = true;
        isSignedin = true;
        checkAuthStatus = true;
      });
    } else {
      print("auth state2:${authStatus.isSignedIn}");
      setState(() {
        checkAuthStatus = true;
      });
      return LoginPage();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final UserLoggedInProvider =
    ChangeNotifierProvider<UserLoggedIn>((ref) => UserLoggedIn());

class UserLoggedIn extends ChangeNotifier {
  bool isUserSignedIn = false;

  void setUserCurrentState(bool userState) {
    this.isUserSignedIn = userState;
    print("user sign in is $userState");
    notifyListeners();
  }

  bool getUserCurrentState() {
    print("get user is$isUserSignedIn");
    return this.isUserSignedIn;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_system_using_firebase/LoginScreen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}

import 'dart:async';

import 'package:firebase_practice/views/login.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login())));
  }
}

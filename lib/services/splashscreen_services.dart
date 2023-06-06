import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/firestore/firestore_list_screen.dart';
import 'package:firebase_practice/views/login.dart';
import 'package:firebase_practice/views/posts.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const FirestoreScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login())));
    }
  }
}

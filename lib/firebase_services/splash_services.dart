import 'dart:async';

import 'package:firebase/auth/login_screen.dart';
import 'package:firebase/firestore/firestore_list_screen.dart';
import 'package:firebase/home/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    print(user);
    if (user != null) {
      Timer(const Duration(seconds: 4), () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return const FirestoreListScreen();
        }));
      });
    } else {
      Timer(const Duration(seconds: 4), () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return const LoginScreen();
        }));
      });
    }
  }
}

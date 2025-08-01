import 'package:firebase/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices authUser = SplashServices();
  @override
  void initState() {
    authUser.isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 217, 223),
      body: Center(
        child: Text('Firebase'),
      ),
    );
  }
}

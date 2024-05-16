import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/home'); // Replace '/home' with your home page route
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Color(0xff2a0062), Color(0xff520062)]),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/yono.png',
            width: 300,
            height: 300,
          ), // Replace 'your_image.png' with your image asset path
        ),
      ),
    );
  }
}

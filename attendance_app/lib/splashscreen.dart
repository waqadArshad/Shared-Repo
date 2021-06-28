import 'package:attendance_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: signin(),
      duration: 5000,
      imageSrc: "Images/logo.png",
      imageSize: 200,
      text: "CUI Faculty Attendance App",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Color(0xff638AE2),
    );
  }
}
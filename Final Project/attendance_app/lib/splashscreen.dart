import 'package:attendance_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'home.dart';

class Splashscreen extends StatefulWidget {
  final String username;
  final String empid;

  const Splashscreen({Key key, this.username, this.empid}) : super(key: key);
  @override
  _SplashscreenState createState() => _SplashscreenState(username, empid);
}

class _SplashscreenState extends State<Splashscreen> {
  final String username;
  final String empid;

  _SplashscreenState(this.username, this.empid);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xff3f26df)));
    return SplashScreenView(
      home: empid!=null && username!=null?
      GeoFence(username: username, empid: empid)
          : signin(),
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'helperfunctions/sharedpref_helper.dart';
import 'splashscreen.dart';


//TODO: GeoFence
//TODO: Time 8-11[check-in] & 4-7[check-out](16-19)
//TODO: SharedPreference


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  var userName = await SharedPreferenceHelper().getUserName();
  var empid = await SharedPreferenceHelper().getUserEmail();
  print("userName from shared preference is: ");
  print(userName);
  print("userEmail from shared preference is: ");
  print(empid);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splashscreen(username: userName, empid: empid),
  ));
}




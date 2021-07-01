import 'package:attendance_app/drawer.dart';
import 'package:attendance_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xff3F26DF)));
    return Scaffold(
        drawer: navigationMenufunction(context),
        appBar: AppBar(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: IconButton(
            icon: Icon(Icons.home_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeoFence(),
                ),
              );
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app_rounded),
                onPressed: () {
                  SystemNavigator.pop();
                }),
          ],
          title: Text(
            'Contact Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          // toolbarHeight: 50,
          backgroundColor: Color(0xff3f55dd),
        ),
        backgroundColor: Color(0xff638AE2),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
                child: Image(
                  image: AssetImage("Images/logo.png"),
                )),
            new Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Text(
                  "CUI Faculty Attendance App",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Text(
                  "COMSATS University Islamabad,\nVehari Campus\nMailsi Road, Off Multan Road,\nVehari, Punjab,\nPakistan",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Text(
                  "cuivehari@gmail.com",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Text(
                  "Phone No# +92-67-3602803",
                  style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Divider(
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 7,
                ),
                Text(
                  "Developed by:"
                      "\nWaqad"
                      "\nM. Sheraz Jamil"
                      "\nM. Ayyaz Khan"
                      "\nSyed Mustahsan"
                      "\nMuqaddas Javed",
                  style: TextStyle(color:Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            new Divider(
              color: Colors.white,
            ),
          ]),
        ));
  }
}
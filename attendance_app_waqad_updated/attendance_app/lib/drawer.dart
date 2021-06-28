import 'package:attendance_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'contactus.dart';
import 'helperfunctions/sharedpref_helper.dart';
import 'home.dart';

Widget navigationMenufunction(BuildContext context) {
  var navigationMenu = Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: Container(
            alignment: Alignment.center,
            child: Image.asset('Images/logo.png'),
          ),
          // decoration: BoxDecoration(
          //   color: Color(0xff638AE2),
          // ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            'Home',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GeoFence()),
            );
          },
        ),
        new Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: Icon(Icons.fingerprint_rounded,
          color: Colors.black,
          ),
          title: Text(
            'Fingerprint Reader',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => fingerprint(),
            //   ),
            // );
          },
        ),
        new Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: Image.asset('Images/7.png'),
          title: Text(
            'Face Recognition',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => face(),
            //   ),
            // );
          },
        ),
        new Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: Icon(Icons.phone,
          color: Colors.black,
          ),
          title: Text(
            'Contact_Us',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUs()),
            );
          },
        ),
        new Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app,
          color: Colors.black,
          ),
          title: Text(
            'Exit',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          onTap: () {
            SystemNavigator.pop();
            },
        ),
        new Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app,
            color: Colors.black,
          ),
          title: Text(
            'Logout',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
            color: Colors.red),
          ),
          onTap: () async {
            bool islogOut= await SharedPreferenceHelper().logOut();
            print("islogOut: $islogOut");
            if(islogOut){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => signin()),
              );
            }
          },
        ),
        new Divider(
          color: Colors.black,
        ),
      ],
    ),
  );
  return navigationMenu;
}
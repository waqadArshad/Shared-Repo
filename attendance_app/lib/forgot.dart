import 'package:attendance_app/drawer.dart';
import 'signin.dart';
import 'package:flutter/material.dart';


class forgot extends StatefulWidget {
  @override
  _forgotState createState() => _forgotState();
}

class _forgotState extends State<forgot> {
  final num = new TextEditingController();
  final psw = new TextEditingController();
  final email = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    // debugShowCheckedModeBanner: false,
    return Scaffold(
      drawer: navigationMenufunction(context),
        backgroundColor: Colors.blue[600],
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Image.asset('Images/8.png',
                    alignment: Alignment.centerLeft,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: 400,
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.indigo, width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 3.0),
                          ),
                          hintText: '35201-7865645-6',
                          labelText: 'CNIC/ID',
                          hintStyle: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      obscureText: false,
                      controller: num,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: 400,
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.indigo, width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 3.0),
                          ),
                          hintText: 'abc@gmail.com',
                          labelText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      obscureText: false,
                      controller: email,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  width: 400,
                  child: Center(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.indigo, width: 3.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 3.0),
                          ),
                          hintText: 'Your Password',
                          labelText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey[200],
                            fontSize: 20,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      controller: psw,
                      obscureText: true,
                      maxLength: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff3f55dd), Color(0xff3f55dd)])),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Save',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Icon(
                            Icons.save_alt_rounded,
                            color: Colors.black,
                            size: 35,
                            semanticLabel:
                            'Text to announce in accessibility modes',
                          ),
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => signin(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ]),
        ));
    // );
  }
}
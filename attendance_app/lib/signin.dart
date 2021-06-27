import 'forgot.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {
  final num = new TextEditingController();
  final psw = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Image.asset('Images/6.png',
                    alignment: Alignment.centerLeft,
                  ),
                ),
                SizedBox(
                  height: 40,
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
                            'Sign IN',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                          Icon(
                            Icons.exit_to_app_rounded,
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
                        builder: (context) => home(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  child:Container(
                    child: Text('Forgot Password? Reset',
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => forgot(),
                      ),
                    );

                  },
                ),
              ]),
        ));
    // );
  }
}
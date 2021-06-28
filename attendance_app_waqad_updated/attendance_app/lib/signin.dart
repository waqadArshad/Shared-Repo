import 'package:attendance_app/services/database.dart';
import 'package:flutter/services.dart';

import 'forgot.dart';
import 'package:flutter/material.dart';
import 'helperfunctions/sharedpref_helper.dart';
import 'home.dart';

class signin extends StatefulWidget {
  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {

  final usernameCon = new TextEditingController();
  final passCon = new TextEditingController();
  bool isPressed=false;
  Map<String, dynamic> data = {};

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        isPressed=false;
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sorry!"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[600],
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'Images/6.png',
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
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
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
                  controller: usernameCon,
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
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
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
                  controller: passCon,
                  obscureText: true,
                  maxLength: 20,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            isPressed?CircularProgressIndicator():SizedBox(
              height: 5,
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
              onTap: () async {
                SystemChannels.textInput.invokeMethod('TextInput.hide');
                isPressed=true;
                setState(() {});
                DatabaseMethods().FetchAll(usernameCon.text).then((value) async {

                  data = value;
                  if (data!=null) {
                    print("inside data not empty if: data: $data");
                    if (data['empid'] == usernameCon.text &&
                        data['password'] == passCon.text) {
                      print("inside comparison if usernameCon: ${usernameCon.text}"
                          "passCon: ${passCon.text}");
                      bool isSavedUserName = await SharedPreferenceHelper().saveUserName(usernameCon.text);
                      bool isSavedUserEmail = await SharedPreferenceHelper().saveUserEmail(data['empid']);
                      print("After saving data");
                      print(isSavedUserName);
                      print(isSavedUserEmail);
                      isPressed=false;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GeoFence(),
                        ),
                      );
                    } else {
                      showAlertDialog(
                          context,
                          "Wrong password,\n"
                              "please try again with the right ones.");
                    }
                  }
                  else {
                    print("inside data empty else: ");

                    showAlertDialog(
                        context,
                        "No Record exists against the credentials,\n"
                            "please try again with the right ones.");
                  }
                });

              },
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              child: Container(
                child: Text(
                  'Forgot Password? Reset',
                  style: TextStyle(
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
            SizedBox(
              height: 5,
            ),
          ]
          ),
        ));
    // );
  }
}

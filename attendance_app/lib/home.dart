import 'package:attendance_app/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: navigationMenufunction(context),
          backgroundColor: Colors.blue[600],
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "Images/5.png",
                  alignment: Alignment.centerLeft,
                  //height: 200,
                  //width: 2000,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // GestureDetector(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    //     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(5)),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [Color(0xff3f55dd), Color(0xff3f55dd)])),
                    //     child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: <Widget>[
                    //           Text(
                    //             'Fingerprint\nReader',
                    //             style: TextStyle(fontSize: 20, color: Colors.white),
                    //           ),
                    //           Icon(
                    //             Icons.fingerprint_rounded,
                    //             color: Colors.black,
                    //             size: 35,
                    //           ),
                    //         ]),
                    //   ),
                    //   onTap: () {},
                    // ),
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
                                'Face\nRecognition',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              Image.asset('Images/7.png'),
                            ]),
                      ),
                      onTap: () {},
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
                                'Record',
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              Icon(
                                Icons.receipt_long_outlined,
                                color: Colors.black,
                                size: 35,
                              ),
                            ]),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

import 'dart:async';
import 'dart:core';
import 'package:attendance_app/drawer.dart';
import 'package:attendance_app/services/database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart' as vcm;
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dataShow.dart';

// class home extends StatefulWidget {
//   final String username;
//   final String email;
//
//   const home({Key key, this.username, this.email}) : super(key: key);
//   @override
//   _homeState createState() => _homeState(username, email);
// }
//
// class _homeState extends State<home> {
//   final String username;
//   final String email;
//
//   _homeState(this.username, this.email);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           drawer: navigationMenufunction(context),
//           backgroundColor: Colors.blue[600],
//           body: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 alignment: Alignment.centerLeft,
//                 child: Image.asset(
//                   "Images/5.png",
//                   alignment: Alignment.centerLeft,
//                   //height: 200,
//                   //width: 2000,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     // GestureDetector(
//                     //   child: Container(
//                     //     width: MediaQuery.of(context).size.width,
//                     //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                     //     margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     //     alignment: Alignment.center,
//                     //     decoration: BoxDecoration(
//                     //         borderRadius: BorderRadius.all(Radius.circular(5)),
//                     //         gradient: LinearGradient(
//                     //             begin: Alignment.centerLeft,
//                     //             end: Alignment.centerRight,
//                     //             colors: [Color(0xff3f55dd), Color(0xff3f55dd)])),
//                     //     child: Row(
//                     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //         children: <Widget>[
//                     //           Text(
//                     //             'Fingerprint\nReader',
//                     //             style: TextStyle(fontSize: 20, color: Colors.white),
//                     //           ),
//                     //           Icon(
//                     //             Icons.fingerprint_rounded,
//                     //             color: Colors.black,
//                     //             size: 35,
//                     //           ),
//                     //         ]),
//                     //   ),
//                     //   onTap: () {},
//                     // ),
//                     GestureDetector(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(5)),
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [Color(0xff3f55dd), Color(0xff3f55dd)])),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 'Face\nRecognition',
//                                 style: TextStyle(fontSize: 20, color: Colors.white),
//                               ),
//                               Image.asset('Images/7.png'),
//                             ]),
//                       ),
//                       onTap: () {},
//                     ),
//                     GestureDetector(
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//                         margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(5)),
//                             gradient: LinearGradient(
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                                 colors: [Color(0xff3f55dd), Color(0xff3f55dd)])),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 'Record',
//                                 style: TextStyle(fontSize: 20, color: Colors.white),
//                               ),
//                               Icon(
//                                 Icons.receipt_long_outlined,
//                                 color: Colors.black,
//                                 size: 35,
//                               ),
//                             ]),
//                       ),
//                       onTap: () {},
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

class GeoFence extends StatefulWidget {
  final String username;
  final String empid;

  const GeoFence({Key key, this.username, this.empid}) : super(key: key);

  @override
  _GeoFenceState createState() => _GeoFenceState(username, empid);
}

class _GeoFenceState extends State<GeoFence> {
  final String username;
  final String empid;
  _GeoFenceState(this.username, this.empid);
  final _streamController = StreamController<PolyGeofence>();
  String content = "";
  Map<String, dynamic> fenceData = {};
  Map<String, dynamic> empAttendanceMap = {};
  Map<String, dynamic> fetchEmpAttendanceDataMap = {};
  bool alreadyMarked = false;

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
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

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      allowMockLocations: true,
      printDevLog: true);

  // Create a [PolyGeofence] list.
  final _polyGeofenceList = <PolyGeofence>[
    PolyGeofence(
      id: 'Waqad Home',
      data: {
        'address': 'Chak 84 P, Vehari, Punjab, Pakistan',
        'about': 'Waqad\'s home in chak no. 8/w.b.'
      },

      /*
      (30.117446597868774, 72.4657641152569)
      (30.117720581058435, 72.46575338642084)
      (30.117597615639767, 72.46370417873347)
      (30.11728208103481, 72.46388388673746)
      (30.117309711447316, 72.46577216188395)
      (30.117446597868774, 72.4657641152569)
      *
      #!2nd time.

      (30.119001166216247, 72.46321678303818)
      (30.118880522465453, 72.46814131878952)
      (30.117005885248492, 72.46839881085495)
      (30.11685739761157, 72.4637424960051)
      (30.119001166216247, 72.46321678303818)

      */
      polygon: <LatLng>[
        const LatLng(30.119001166216247, 72.46321678303818),
        const LatLng(30.118880522465453, 72.46814131878952),
        const LatLng(30.117005885248492, 72.46839881085495),
        const LatLng(30.11685739761157, 72.4637424960051),
        const LatLng(30.119001166216247, 72.46321678303818),
        // const LatLng(30.117446597868774, 72.4657641152569)
      ],
    ),
  ];

  // This function is to be called when the geofence status is changed.
  Future<void> _onPolyGeofenceStatusChanged(PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus, Position position) async {
    print('geofence: ${polyGeofence.toJson()}');
    print('position in geofence: ${position.toJson()}');
    _streamController.sink.add(polyGeofence);
  }

  // This function is to be called when the position has changed.
  void _onPositionChanged(Position position) {
    setState(() {
      position.toJson().forEach((key, value) {
        content += "key: $key value: $value \n";
      });
    });

    print('content: $content');
    print('position: ${position.toJson()}');
  }

  // This function is to be called when a location service status change occurs
  // since the service was started.
  void _onLocationServiceStatusChanged(bool status) {
    print('location service status: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }

    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _polyGeofenceService
          .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addPositionChangeListener(_onPositionChanged);
      _polyGeofenceService.addLocationServiceStatusChangeListener(
          _onLocationServiceStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xff3F26DF)));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // A widget used when you want to start a foreground task when trying to minimize or close the app.
      // Declare on top of the [Scaffold] widget.
      home: WillStartForegroundTask(
        onWillStart: () {
          // You can add a foreground task start condition.
          return _polyGeofenceService.isRunningService;
        },
        notificationOptions: const NotificationOptions(
            channelId: 'geofence_service_notification_channel',
            channelName: 'Geofence Service Notification',
            channelDescription:
                'This notification appears when the geofence service is running in the background.',
            channelImportance: NotificationChannelImportance.LOW,
            priority: NotificationPriority.LOW),
        notificationTitle: 'Geofence Service is running',
        notificationText: 'Tap to return to the app',
        child: Scaffold(
          // appBar: AppBar(
          //     title: const Text('Poly Geofence Service'),
          //     centerTitle: true
          // ),
          body: Scaffold(
            drawer: navigationMenufunction(context),
            backgroundColor: Colors.white,
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
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff3f55dd),
                                    Color(0xff3f55dd)
                                  ])),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Mark\nAttendance',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ]),
                        ),
                        onTap: () async {
                          if (fenceData != null) {
                            fenceData.forEach((key, value) {
                              print("fenceData in onAttendance key is: $key &"
                                  " fenceData in onAttendance value is: $value");
                            });
                            print(
                                "fenceData['status'].toString().split('.')[1]!='EXIT'"
                                "${fenceData['status'].toString().split('.')[1] != "EXIT"}");
                            if (fenceData['status'].toString().split('.')[1] !=
                                "EXIT") {
                              initializeDateFormatting();
                              DateTime now = new DateTime.now();
                              DateTime date =
                                  new DateTime(now.year, now.month, now.day);
                              var format = DateFormat('dd-MM-yyyy');
                              var dateString = format.format(date);
                              print("date is: $dateString");
                              if (now.hour >= 8 && now.hour <= 11) {
                                print('You can Mark your Attendance');
                                fetchEmpAttendanceDataMap =
                                    await DatabaseMethods()
                                        .FetchAttendanceData(empid, dateString)
                                        .then((value) async {
                                  fetchEmpAttendanceDataMap = value;
                                  if (fetchEmpAttendanceDataMap == null) {
                                    print("fetchEmpAttendanceDataMap==null: "
                                        "${fetchEmpAttendanceDataMap == null}");
                                    empAttendanceMap = {
                                      "empid": empid,
                                      "check-in": '${now.hour}:${now.minute}',
                                      "check-out": '',
                                      "date": dateString,
                                    };
                                    await DatabaseMethods()
                                        .markAttendanceCheckIn(
                                            empid, empAttendanceMap);
                                    showAlertDialog(
                                        context, "Check-in, Marked!");
                                  } else if ((fetchEmpAttendanceDataMap[
                                                  'check-in'] !=
                                              '' &&
                                          fetchEmpAttendanceDataMap[
                                                  'check-in'] !=
                                              null) &&
                                      (fetchEmpAttendanceDataMap['check-out'] ==
                                              '' &&
                                          fetchEmpAttendanceDataMap[
                                                  'check-out'] !=
                                              null) &&
                                      (now.hour >= 16 && now.hour <= 19)) {
                                    print(
                                        "fetchEmpAttendanceDataMap['check-in']!='': "
                                        "${fetchEmpAttendanceDataMap['check-in'] != ''}"
                                        "&& fetchEmpAttendanceDataMap['check-out']==''"
                                        "${fetchEmpAttendanceDataMap['check-out'] == ''}");
                                    empAttendanceMap = {
                                      "check-out": '${now.hour}:${now.minute}',
                                    };
                                    await DatabaseMethods()
                                        .markAttendanceCheckOut(
                                            empid, empAttendanceMap);
                                    showAlertDialog(context, "Done, Marked!");
                                  } else if ((fetchEmpAttendanceDataMap[
                                                  'check-in'] !=
                                              '' &&
                                          fetchEmpAttendanceDataMap[
                                                  'check-in'] !=
                                              null) &&
                                      (fetchEmpAttendanceDataMap['check-out'] !=
                                              '' &&
                                          fetchEmpAttendanceDataMap[
                                                  'check-out'] !=
                                              null)) {
                                    print("Already Marked: $alreadyMarked"
                                        "fetchEmpAttendanceDataMap['check-out']"
                                        "${fetchEmpAttendanceDataMap['check-out']}"
                                        "fetchEmpAttendanceDataMap['check-in']"
                                        "${fetchEmpAttendanceDataMap['check-in']}");
                                    setState(() {});
                                    alreadyMarked = true;
                                    showAlertDialog(context,
                                        "Attendance is already Marked!");
                                  } else {
                                    print("In else. Something bad happened!");
                                    showAlertDialog(context,
                                        "In else. Something bad happened!");
                                  }
                                });
                              } else {
                                showAlertDialog(
                                    context,
                                    "You cannot mark your attendance\n"
                                    "due to time constraints");
                                print('You cannot mark your attendance'
                                    'due to time constraints');
                              }
                            } else {
                              showAlertDialog(
                                  context,
                                  "You cannot mark your attendance\n"
                                  "because you are not in the university.");
                              print(
                                  'You cannot mark your attendance status is = EXIT');
                            }
                          } else {
                            showAlertDialog(
                                context,
                                "You cannot mark your attendance\n"
                                "because you are not in the university.");
                            print(
                                'You cannot mark your attendance, no geofence data found.'
                                'geofencedata is: $fenceData');
                          }
                          ;
                          // initializeDateFormatting();
                          // DateTime now = new DateTime.now();
                          // DateTime date =
                          //     new DateTime(now.year, now.month, now.day);
                          // var format = DateFormat('dd-MM-yyyy');
                          // var dateString = format.format(date);
                          // print("date is: $dateString");

                          // await DatabaseMethods().
                          // markAttendanceCheckIn(empid, empAttendanceMap);
                        },
                      ),
                      // GestureDetector(
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 15, horizontal: 15),
                      //     margin: EdgeInsets.symmetric(
                      //         horizontal: 15, vertical: 15),
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(5)),
                      //         gradient: LinearGradient(
                      //             begin: Alignment.centerLeft,
                      //             end: Alignment.centerRight,
                      //             colors: [
                      //               Color(0xff3f55dd),
                      //               Color(0xff3f55dd)
                      //             ])),
                      //     child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: <Widget>[
                      //           Text(
                      //             'Face\nRecognition',
                      //             style: TextStyle(
                      //                 fontSize: 20, color: Colors.white),
                      //           ),
                      //           Image.asset('Images/7.png'),
                      //         ]),
                      //   ),
                      //   onTap: () {},
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff3f55dd),
                                    Color(0xff3f55dd)
                                  ])),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Record',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Icon(
                                  Icons.receipt_long_outlined,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ]),
                        ),
                        onTap: () {
                          DatabaseMethods().FetchAll(username).then(
                                  (value) {
                            Map<String,dynamic> fetchedData=value;
                            if(fetchedData!=null && fetchedData!={}){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DataShow(fetchedData: fetchedData),
                                ),
                              );
                            }
                            else{
                              showAlertDialog(context, "Sorry, There is some problem in"
                                  "finding your data");
                            }
                          });
                        },
                      ),
                      _buildContentView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Widget _buildContentView() {
    return StreamBuilder<PolyGeofence>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        final updatedDateTime = DateTime.now();
        if (snapshot.hasData) {
          print("inside hasData");
        } else {
          print("inside else");
        }
        content = snapshot.data?.toJson().toString() ??
            'You do not seem to be inside the Geofence';
        fenceData = snapshot.data?.toJson();
        if (fenceData != null) {
          fenceData.forEach((key, value) {
            print("fenceData key is: $key & fenceData value is: $value");
          });

          print("Status: ${fenceData['status'].toString().split('.')[1]}");
        }

        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: SingleChildScrollView(
                child: Text(fenceData != null && fenceData != {}
                    ? "Geofence Id: ${fenceData['id']}\n"
                        "Geofence Status: ${fenceData['status'].toString().split('.')[1]}"
                    : "You do not seem to be inside the Geofence")),
          ),
        );
      },
    );
  }
}

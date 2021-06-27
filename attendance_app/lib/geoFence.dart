import 'dart:async';
import 'package:flutter/material.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_activity_recognition/flutter_activity_recognition.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math.dart';


void main() => runApp(ExampleApp());

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final _streamController = StreamController<PolyGeofence>();
  String content="";

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
  Future<void> _onPolyGeofenceStatusChanged(
      PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus,
      Position position) async {
    print('geofence: ${polyGeofence.toJson()}');
    print('position in geofence: ${position.toJson()}');
    _streamController.sink.add(polyGeofence);
  }

  // This function is to be called when the position has changed.
  void _onPositionChanged(Position position) {
    setState(() {
      position.toJson().forEach((key, value) {
        content+="key: $key value: $value \n";
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
      _polyGeofenceService.addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addPositionChangeListener(_onPositionChanged);
      _polyGeofenceService.addLocationServiceStatusChangeListener(_onLocationServiceStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            channelDescription: 'This notification appears when the geofence service is running in the background.',
            channelImportance: NotificationChannelImportance.LOW,
            priority: NotificationPriority.LOW
        ),
        notificationTitle: 'Geofence Service is running',
        notificationText: 'Tap to return to the app',
        child: Scaffold(
            appBar: AppBar(
                title: const Text('Poly Geofence Service'),
                centerTitle: true
            ),
            body: _buildContentView()
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
        if(snapshot.hasData){
          print("inside hasData");
        }
        else{
          print("inside else");
        }
        content += snapshot.data?.toJson().toString() ?? 'Bullied';

        return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8.0),
            children: [
              Text('•\t\tPolyGeofence (updated: $updatedDateTime)'),
              const SizedBox(height: 10.0),
              Text(content)
            ]
        );
      },
    );
  }
}
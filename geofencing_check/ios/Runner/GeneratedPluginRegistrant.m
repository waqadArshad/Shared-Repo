//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_activity_recognition/FlutterActivityRecognitionPlugin.h>)
#import <flutter_activity_recognition/FlutterActivityRecognitionPlugin.h>
#else
@import flutter_activity_recognition;
#endif

#if __has_include(<flutter_foreground_task/FlutterForegroundTaskPlugin.h>)
#import <flutter_foreground_task/FlutterForegroundTaskPlugin.h>
#else
@import flutter_foreground_task;
#endif

#if __has_include(<flutter_radar/RadarFlutterPlugin.h>)
#import <flutter_radar/RadarFlutterPlugin.h>
#else
@import flutter_radar;
#endif

#if __has_include(<geolocator/GeolocatorPlugin.h>)
#import <geolocator/GeolocatorPlugin.h>
#else
@import geolocator;
#endif

#if __has_include(<poly_geofence_service/PolyGeofenceServicePlugin.h>)
#import <poly_geofence_service/PolyGeofenceServicePlugin.h>
#else
@import poly_geofence_service;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterActivityRecognitionPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterActivityRecognitionPlugin"]];
  [FlutterForegroundTaskPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterForegroundTaskPlugin"]];
  [RadarFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"RadarFlutterPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [PolyGeofenceServicePlugin registerWithRegistrar:[registry registrarForPlugin:@"PolyGeofenceServicePlugin"]];
}

@end

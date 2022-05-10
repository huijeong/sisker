import 'package:device_info/device_info.dart';
// import 'package:android_device_info/android_device_info.dart' as android;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';
import 'package:uuid/uuid.dart';

Future<String?> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android

  }
}

// Future<String?> getDeviceId() async {
//   var device_id = await shared_pref.load(DEVICE_ID);
//   var uuid = Uuid();
//   if (util.isEmpty(device_id)) {
//     var v4_uuid = uuid.v4();
//     shared_pref.save(DEVICE_ID, v4_uuid);
//     return v4_uuid;
//   } else {
//     return device_id;
//   }
// }

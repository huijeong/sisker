import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/login_model.dart';
import 'package:getko/src/util/device.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class AuthApiProvider {
  final _endpoint = "$END_POINT/rest-auth";
  final Dio _dio = Dio();

  Future<LoginModel> login() async {
    try {
      // String? username = "mhb8436";
      String? username = await getDeviceId();
      Response resp = await _dio.post("$_endpoint/login/",
          data: {'username': username, 'password': username});
      return LoginModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to Login Please register user with device id');
    }
  }
}

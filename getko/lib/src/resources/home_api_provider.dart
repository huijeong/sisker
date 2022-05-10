import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/models/home_top_product_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class HomeApiProvider {
  final _endpoint = "$END_POINT/home";
  final Dio _dio = Dio();

  Future<HomeRecommendModel> recommend() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      print('token => $token');
      Response resp = await _dio.get("$_endpoint/recommend/",
          options: Options(headers: {"Authorization": "Token $token"}));
      return HomeRecommendModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to get Home Recommend Product list');
    }
  }

  Future<HomeTopModel> top() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/top/",
          options: Options(headers: {"Authorization": "Token $token"}));
      return HomeTopModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error, stacktrace: $stacktrace');
      throw Exception('Fail to get Home Top Product list');
    }
  }
}

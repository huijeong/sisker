import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/top_keyword_category_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class ProductApiProvider {
  final _endpoint = "$END_POINT/catalogue";
  final Dio _dio = Dio();

  Future<SearchProductModel> search(String keyword) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      print('ProductApiProvider url => ${"$_endpoint/search/$keyword/"}');
      Response resp = await _dio.get("$_endpoint/search/$keyword/",
          options: Options(headers: {"Authorization": "Token $token"}));
      print('ProductApiProvider resp => ${resp.data}');
      return SearchProductModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print(
          'Exception occured: $error stackTrace: $stacktrace, keyword : $keyword');
      throw Exception('Fail to get Search Product list => $keyword');
    }
  }

  Future<ProductOptionModel> option(String product_no) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/option/$product_no/",
          options: Options(headers: {"Authorization": "Token $token"}));
      // print('ProductApiProvider resp => ${resp.data}');
      return ProductOptionModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print(
          'Exception occured: $error stackTrace: $stacktrace, keyword : $product_no');
      throw Exception('Fail to get Search Product list => $product_no');
    }
  }

  Future<TopKeywordCategoryModel> topKeyword() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/top/",
          options: Options(headers: {"Authorization": "Token $token"}));
      // print('ProductApiProvider resp => ${resp.data}');
      return TopKeywordCategoryModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace, keyword ');
      throw Exception('Fail to get Top Keyword ');
    }
  }
}

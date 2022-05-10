import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/models/orders_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class OrderApiProvider {
  final _endpoint = "$END_POINT/orders";
  final Dio _dio = Dio();

  Future<OrderModel> list() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/",
          options: Options(headers: {"Authorization": "Token $token"}));
      // print('ProductApiProvider resp => ${resp.data}');
      return OrderModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to get Cart list');
    }
  }

  Future<OrderModel> add(
      String address_id,
      String payment_card,
      String full_name,
      String email,
      String address1,
      String address2,
      String phone,
      String postal_code) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      print('order add => $token ');
      address_id = address_id == '' ? 'null' : address_id;
      Response resp = await _dio.post("$_endpoint/",
          data: {
            'address_id': address_id,
            'payment_card': payment_card,
            'full_name': full_name,
            'email': email,
            'address1': address1,
            'address2': address2,
            'phone': phone,
            'postal_code': postal_code,
          },
          options: Options(headers: {"Authorization": "Token $token"}));
      return OrderModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to add to cart....');
    }
  }
}

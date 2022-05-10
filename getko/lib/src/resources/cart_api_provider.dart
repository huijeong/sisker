import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class CartApiProvider {
  final _endpoint = "$END_POINT/basket";
  final Dio _dio = Dio();

  Future<CartModel> list() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/",
          options: Options(headers: {"Authorization": "Token $token"}));
      // print('ProductApiProvider resp => ${resp.data}');
      return CartModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to get Cart list');
    }
  }

  Future<CartModel> add(String product_no, ProductOptionModel option, int price,
      int quantity, String item) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.post("$_endpoint/",
          data: {
            'product': product_no,
            'option': jsonEncode(option),
            'price': price,
            'quantity': quantity,
            'item': item
          },
          options: Options(headers: {"Authorization": "Token $token"}));
      return CartModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to add to cart....');
    }
  }

  Future<CartModel> delete(int cardId) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.delete("$_endpoint/$cardId/",
          data: {},
          options: Options(headers: {"Authorization": "Token $token"}));
      return CartModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to delete to cart....');
    }
  }

  Future<CartModel> update(int cardId, int quantity) async {
    print('update cart item $cardId, $quantity');
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.put("$_endpoint/$cardId/",
          data: {'quantity': quantity},
          options: Options(headers: {"Authorization": "Token $token"}));
      print('update cart item result ${resp.data}');
      return CartModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to update quantiy to cart....');
    }
  }
}

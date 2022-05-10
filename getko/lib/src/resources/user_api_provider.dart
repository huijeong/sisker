import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getko/src/models/credit_card_model.dart';
import 'package:getko/src/models/address_model.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class UserApiProvider {
  final _endpoint = "$END_POINT/user";
  final Dio _dio = Dio();

  Future<CreditCardModel> listCreditcard() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/creditcard/",
          options: Options(headers: {"Authorization": "Token $token"}));

      return CreditCardModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to get card list');
    }
  }

  Future<CreditCardModel> addCreditCard(String number, String month,
      String year, String password, String name) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.post("$_endpoint/creditcard/",
          data: {
            'number': number,
            'month': month,
            'year': year,
            'password': password,
            'name': name
          },
          options: Options(headers: {"Authorization": "Token $token"}));
      return CreditCardModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to add to card....');
    }
  }

  Future<CreditCardModel> deleteCreditCard(int cardId) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.delete("$_endpoint/creditcard/$cardId/",
          data: {},
          options: Options(headers: {"Authorization": "Token $token"}));
      return CreditCardModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to delete to card....');
    }
  }

  Future<AddressModel> listAddress() async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.get("$_endpoint/address/",
          options: Options(headers: {"Authorization": "Token $token"}));

      return AddressModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to get address list');
    }
  }

  Future<AddressModel> addAddress(
      String full_name,
      String phone,
      String email,
      String postcode,
      String address_line,
      String address_line2,
      String town_city,
      String country) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.post("$_endpoint/address/",
          data: {
            'full_name': full_name,
            'phone': phone,
            'email': email,
            'postcode': postcode,
            'address_line': address_line,
            'address_line2': address_line2,
            'town_city': town_city,
            'country': country,
          },
          options: Options(headers: {"Authorization": "Token $token"}));
      return AddressModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to add to address....');
    }
  }

  Future<AddressModel> deleteAddress(String cardId) async {
    try {
      String? token = await shared_pref.load(TOKEN);
      Response resp = await _dio.delete("$_endpoint/address/$cardId/",
          data: {},
          options: Options(headers: {"Authorization": "Token $token"}));
      return AddressModel.fromJson(resp.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception('Fail to delete to address....');
    }
  }
}

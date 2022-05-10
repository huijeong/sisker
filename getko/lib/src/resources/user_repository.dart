import 'dart:async';
import 'package:getko/src/resources/user_api_provider.dart';
import 'package:getko/src/models/address_model.dart';
import 'package:getko/src/models/credit_card_model.dart';

class UserRepository {
  final _userApiProvider = UserApiProvider();

  Future<CreditCardModel> listCreditCard() => _userApiProvider.listCreditcard();

  Future<CreditCardModel> addCreditCard(String number, String month,
          String year, String password, String name) =>
      _userApiProvider.addCreditCard(number, month, year, password, name);

  Future<CreditCardModel> deleteCreditCard(int cartId) =>
      _userApiProvider.deleteCreditCard(cartId);

  Future<AddressModel> listAddress() => _userApiProvider.listAddress();

  Future<AddressModel> addAddress(
          String full_name,
          String phone,
          String email,
          String postcode,
          String address_line,
          String address_line2,
          String town_city,
          String country) =>
      _userApiProvider.addAddress(full_name, phone, email, postcode,
          address_line, address_line2, town_city, country);

  Future<AddressModel> deleteAddress(String cartId) =>
      _userApiProvider.deleteAddress(cartId);
}

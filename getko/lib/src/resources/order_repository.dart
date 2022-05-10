import 'dart:async';
import 'package:getko/src/resources/order_api_provider.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/models/orders_model.dart';

class OrderRepository {
  final _orderApiProvider = OrderApiProvider();

  Future<OrderModel> list() => _orderApiProvider.list();

  Future<OrderModel> add(
          String address_id,
          String payment_card,
          String full_name,
          String email,
          String address1,
          String address2,
          String phone,
          String postal_code) =>
      _orderApiProvider.add(address_id, payment_card, full_name, email,
          address1, address2, phone, postal_code);
}

import 'dart:async';
import 'package:getko/src/resources/cart_api_provider.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/cart_model.dart';

class CartRepository {
  final _cartApiProvider = CartApiProvider();

  Future<CartModel> list() => _cartApiProvider.list();

  Future<CartModel> add(String product_no, ProductOptionModel option, int price,
          int quantity, String item) =>
      _cartApiProvider.add(product_no, option, price, quantity, item);

  Future<CartModel> delete(int cartId) => _cartApiProvider.delete(cartId);

  Future<CartModel> update(int cartId, int quantity) =>
      _cartApiProvider.update(cartId, quantity);
}

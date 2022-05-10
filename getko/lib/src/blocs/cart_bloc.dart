import 'package:rxdart/rxdart.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/resources/cart_repository.dart';
import 'package:getko/src/models/product_option_model.dart';

class CartBloc {
  final _repository = CartRepository();
  final _cartListFetcher = BehaviorSubject<CartModel>();
  final _cartAddFetcher = BehaviorSubject<CartModel>();
  final _cartDeleteFetcher = BehaviorSubject<CartModel>();
  final _cartUpdateFetcher = BehaviorSubject<CartModel>();

  list() async {
    try {
      CartModel _cartModel = await _repository.list();
      _cartListFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('list() exxception => $ex');
    } catch (er) {
      print('list() error => $er');
    }
  }

  add(String product_no, ProductOptionModel option, int price, int quantity,
      String item) async {
    try {
      CartModel _cartModel =
          await _repository.add(product_no, option, price, quantity, item);
      _cartAddFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('add() exxception => $ex');
    } catch (er) {
      print('add() error => $er');
    }
  }

  delete(int cartId) async {
    try {
      CartModel _cartModel = await _repository.delete(cartId);
      _cartDeleteFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('delete() exxception => $ex');
    } catch (er) {
      print('delete() error => $er');
    }
  }

  update(int cartId, int quantity) async {
    try {
      CartModel _cartModel = await _repository.update(cartId, quantity);
      _cartUpdateFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('update() exxception => $ex');
    } catch (er) {
      print('update() error => $er');
    }
  }

  dispose() {
    _cartListFetcher.close();
    _cartAddFetcher.close();
    _cartDeleteFetcher.close();
    _cartUpdateFetcher.close();
  }

  BehaviorSubject<CartModel> get cartListFetcher => _cartListFetcher;
  BehaviorSubject<CartModel> get cartAddFetcher => _cartAddFetcher;
  BehaviorSubject<CartModel> get cartDeleteFetcher => _cartDeleteFetcher;
  BehaviorSubject<CartModel> get cartUpdateFetcher => _cartUpdateFetcher;
}

final cart_bloc = CartBloc();

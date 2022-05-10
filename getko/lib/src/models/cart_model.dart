import 'package:getko/src/models/home_recommend_product_model.dart';

class CartModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<CartItem> _results;

  CartModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<CartItem> _temp = [];
    print('CartModel fromJson => ${parsedJson}');
    for (int i = 0; i < parsedJson['results'].length; i++) {
      CartItem _item = CartItem(parsedJson['results'][i]);
      _temp.add(_item);
    }
    _results = _temp;
  }

  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<CartItem> get results => _results;
}

class CartItem {
  late int _id;
  late HomeProduct _product;
  late String _item;
  late String _price;
  late int _quantity;

  CartItem(result) {
    _id = result['id'];
    _product = HomeProduct(result['product']);
    _item = result['item'];
    _price = result['price'];
    _quantity = result['quantity'];
  }

  int get id => _id;
  HomeProduct get product => _product;
  String get item => _item;
  String get price => _price;
  int get quantity => _quantity;

  @override
  String toString() {
    return '$_id/${_product.title}/$_item/$_quantity';
  }
}

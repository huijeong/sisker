class OrderModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<Order> _results;

  OrderModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<Order> _temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _temp.add(Order(parsedJson['results'][i]));
    }
    _results = _temp;
  }

  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<Order> get results => _results;
}

class Order {
  late int _id;
  late String _total_paid;
  late String _billing_status;
  late String _order_status;
  late String _created;
  late List<OrderItem> _items;

  Order(result) {
    _id = result['id'];
    _total_paid = result['total_paid'];
    _billing_status = result['billing_status'];
    _order_status = result['order_status'];
    _created = result['created'];
    List<OrderItem> _temp = [];
    for (int i = 0; i < result['items'].length; i++) {
      _temp.add(OrderItem(result['items'][i]));
    }
    _items = _temp;
  }

  int get id => _id;
  String get total_paid => _total_paid;
  String get billing_status => _billing_status;
  String get order_status => _order_status;
  String get created => _created;
  List<OrderItem> get items => _items;
}

class OrderItem {
  late int _id;
  late String _product_no;
  late String _title;
  late String _product_thumbnail;
  late String _price;
  late String _option;
  late int _quantity;
  late String _seller;

  OrderItem(result) {
    _id = result['id'];
    _product_no = result['product']['product_no'];
    _title = result['product']['title'];
    _product_thumbnail = result['product']['product_thumbnail'];
    _price = result['price'];
    _option = result['item'];
    _quantity = result['quantity'];
    _seller = result['product']['seller']['name'];
  }

  int get id => _id;
  String get product_no => _product_no;
  String get title => _title;
  String get product_thumbnail => _product_thumbnail;
  String get price => _price;
  String get option => _option;
  int get quantity => _quantity;
  String get seller => _seller;
}

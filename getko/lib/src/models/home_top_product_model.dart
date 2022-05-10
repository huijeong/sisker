import 'package:getko/src/models/home_recommend_product_model.dart';

class HomeTopModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<TopCategory> _top_categories;

  HomeTopModel.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson['results'].length);
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<TopCategory> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      TopCategory category = TopCategory(parsedJson['results'][i]);
      temp.add(category);
    }
    _top_categories = temp;
  }
  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<TopCategory> get top_categories => _top_categories;
}

// class RecommendCategory {}

class TopCategory {
  late String _name;
  late int _ordering;
  late bool _is_active;
  late List<TopProduct> _related_top_product;
  late String _thumbnail;

  TopCategory(result) {
    // print('_RecommendCategory constructor => $result');
    _name = result['name'];
    _ordering = result['ordering'];
    _is_active = result['is_active'];
    List<TopProduct> temp = [];
    for (int i = 0; i < result['related_top_product'].length; i++) {
      TopProduct product = TopProduct(result['related_top_product'][i]);
      temp.add(product);
    }
    _related_top_product = temp;
    _thumbnail = result['thumbnail'];
  }
  String get name => _name;
  int get ordering => _ordering;
  bool get is_active => _is_active;
  List<TopProduct> get related_top_product => _related_top_product;
  String get thumbnail => _thumbnail;

  @override
  String toString() {
    return "$_name / $_thumbnail / $_related_top_product";
  }
}

class TopProduct {
  late String _start_date;
  late String _end_date;
  late HomeProduct _product;
  late int _ordering;
  late bool _is_active;

  TopProduct(result) {
    _start_date = result['start_date'];
    _end_date = result['end_date'];
    _product = HomeProduct(result['product']);
    _ordering = result['ordering'];
    _is_active = result['is_active'];
  }

  String get start_date => _start_date;
  String get end_date => _end_date;
  HomeProduct get product => _product;
  int get ordering => _ordering;
  bool get is_active => _is_active;

  @override
  String toString() {
    return "$_start_date / $_end_date / $_product";
  }
}

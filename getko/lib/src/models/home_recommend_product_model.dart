class HomeRecommendModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<RecommendCategory> _recommend_categories;

  HomeRecommendModel.fromJson(Map<String, dynamic> parsedJson) {
    // print(parsedJson['results'].length);
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<RecommendCategory> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      RecommendCategory category = RecommendCategory(parsedJson['results'][i]);
      temp.add(category);
    }
    _recommend_categories = temp;
  }
  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<RecommendCategory> get recommend_categories => _recommend_categories;
}

// class RecommendCategory {}

class RecommendCategory {
  late String _name;
  late int _ordering;
  late bool _is_active;
  late List<RecommendProduct> _related_recommend_product;
  late String _thumbnail;

  RecommendCategory(result) {
    // print('_RecommendCategory constructor => $result');
    _name = result['name'];
    _ordering = result['ordering'];
    _is_active = result['is_active'];
    List<RecommendProduct> temp = [];
    for (int i = 0; i < result['related_recommend_product'].length; i++) {
      RecommendProduct product =
          RecommendProduct(result['related_recommend_product'][i]);
      temp.add(product);
    }
    _related_recommend_product = temp;
    _thumbnail = result['thumbnail'];
  }
  String get name => _name;
  int get ordering => _ordering;
  bool get is_active => _is_active;
  List<RecommendProduct> get related_recommend_product =>
      _related_recommend_product;
  String get thumbnail => _thumbnail;

  @override
  String toString() {
    return "$_name / $_thumbnail / $_related_recommend_product";
  }
}

class RecommendProduct {
  late String _start_date;
  late String _end_date;
  late HomeProduct _product;
  late int _ordering;
  late bool _is_active;

  RecommendProduct(result) {
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

class HomeProduct {
  late int _id;
  late String _product_no;
  late String _title;
  late double _regular_price;
  late double _discount_price;
  late String _product_thumbnail;
  late String _product_url;

  HomeProduct(result) {
    _id = result['id'];
    _product_no = result['product_no'];
    _title = result['title'];
    _regular_price = result['regular_price'];
    _discount_price = result['discount_price'];
    _product_thumbnail = result['product_thumbnail'];
    _product_url = result['product_url'];
  }

  int get id => _id;
  String get product_no => _product_no;
  String get title => _title;
  double get regular_price => _regular_price;
  double get discount_price => _discount_price;
  String get product_thumbnail => _product_thumbnail;
  String get product_url => _product_url;

  @override
  String toString() {
    return "$_title / $_regular_price";
  }
}

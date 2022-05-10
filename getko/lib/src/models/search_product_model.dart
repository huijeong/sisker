class SearchProductModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<SearchProduct> _results;

  SearchProductModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<SearchProduct> temp = [];
    // print('results => ${parsedJson['results']}');
    for (int i = 0; i < parsedJson['results'].length; i++) {
      // print('result $i => ${parsedJson['results'][i]}');
      SearchProduct category = SearchProduct(parsedJson['results'][i]);
      // print('searchProduct => $category');
      temp.add(category);
    }
    _results = temp;
  }
  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<SearchProduct> get results => _results;
}

class SearchProduct {
  late String _product_no;
  late String _title;
  late String _description;
  late double _regular_price;
  late double _discount_price;
  late bool _is_active;
  late String _product_thumbnail;
  late String _product_url;

  late List<SearchKeyword> _related_keyword;
  late ProductSeller _seller;

  SearchProduct(result) {
    _product_no = result['product_no'];
    _title = result['title'];
    _description = result['description'];
    _regular_price = result['regular_price'];
    _discount_price = result['discount_price'];
    _is_active = result['is_active'];
    _product_thumbnail = result['product_thumbnail'];
    _product_url = result['product_url'];

    List<SearchKeyword> _temp = [];
    for (int i = 0; i < result['related_keyword'].length; i++) {
      _temp.add(SearchKeyword(result['related_keyword'][i]));
    }
    _related_keyword = _temp;
    _seller = ProductSeller(result['seller']);
  }

  String get product_no => _product_no;
  String get title => _title;
  String get description => _description;
  double get regular_price => _regular_price;
  double get discount_price => _discount_price;
  bool get is_active => _is_active;
  List<SearchKeyword> get related_keyword => _related_keyword;
  ProductSeller get seller => _seller;
  String get product_thumbnail => _product_thumbnail;
  String get product_url => _product_url;

  @override
  String toString() {
    return "$_product_no / $_title ";
  }
}

class SearchKeyword {
  late String _keyword;
  late bool _is_active;

  SearchKeyword(result) {
    _keyword = result['keyword'];
    _is_active = result['is_active'];
  }

  String get keyword => _keyword;
  bool get is_active => _is_active;

  @override
  String toString() {
    return "$_keyword";
  }
}

class ProductSeller {
  late String _name;
  late String _business_name;
  late String _representative;
  late String _business_type;
  late String _customer_telephone_no;
  late String _company_registration_no;
  late String _email;
  late bool _is_active;
  late String _address;

  ProductSeller(result) {
    _name = result['name'];
    _business_name = result['business_name'];
    _representative = result['representative'];
    _business_type = result['business_type'];
    _customer_telephone_no = result['customer_telephone_no'];
    _company_registration_no = result['company_registration_no'];
    _email = result['business_name'];
    _is_active = result['_is_active'];
    _address = result['_address'];
  }

  String get name => _name;
  String get business_name => _business_name;
  String get representative => _representative;
  String get business_type => _business_type;
  String get customer_telephone_no => _customer_telephone_no;
  String get company_registration_no => _company_registration_no;
  String get email => _email;
  bool get is_active => _is_active;
  String get address => _address;
}

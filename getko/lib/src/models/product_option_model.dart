class ProductOptionModel {
  String _exchange = "";
  int _prd_no = 0;
  String _prd_url = "";
  String _prd_nm = "";
  String _prd_brand = "";
  int _price_high = 0;
  int _price_low = 0;
  int _delivery = 0;

  late List<Option> _options = [];

  ProductOptionModel() {}
  ProductOptionModel.fromJson(Map<String, dynamic> parsedJson) {
    _exchange = parsedJson['exchange'];
    _prd_no = parsedJson['prd_no'];
    _prd_url = parsedJson['prd_url'];
    _prd_nm = parsedJson['prd_nm'];
    _prd_brand = parsedJson['prd_brand'];
    _price_high = parsedJson['price_high'];
    _price_low = parsedJson['price_low'];
    _delivery = parsedJson['delivery'];
    List<Option> _temp = [];
    for (int i = 0; i < parsedJson['options'].length; i++) {
      _temp.add(Option(parsedJson['options'][i]));
    }
    _options = _temp;
  }

  String get exchange => _exchange;
  int get prd_no => _prd_no;
  String get prd_url => _prd_url;
  String get prd_nm => _prd_nm;
  String get prd_brand => _prd_brand;
  int get price_high => _price_high;
  int get price_low => _price_low;
  int get delivery => _delivery;

  List<Option> get options => _options;

  Map<String, dynamic> toJson() {
    // print('toJson => $_prd_no');
    return {
      'exchange': _exchange,
      'prd_no': _prd_no,
      'prd_url': _prd_url,
      'prd_nm': _prd_nm,
      'prd_brand': _prd_brand,
      'price_high': _price_high,
      'price_low': _price_low,
      'delivery': _delivery,
      'options': _options
    };
  }

  @override
  String toString() {
    return '$_prd_no / $_prd_nm / $_price_high';
  }
}

class Option {
  late String _txt;
  late int _addPrc;
  late List<Option> _sub;

  Option(result) {
    _txt = result['txt'];
    _addPrc = result['addPrc'];
    List<Option> _temp = [];
    for (int i = 0; result['sub'] != null && i < result['sub'].length; i++) {
      _temp.add(Option(result['sub'][i]));
    }
    _sub = _temp;
  }

  String get txt => _txt;
  int get addPrc => _addPrc;
  List<Option> get sub => _sub;

  Map<String, dynamic> toJson() {
    // print('Option toJson => $_txt, $_addPrc, $_sub');
    return {'txt': _txt, 'addPrc': _addPrc, 'sub': _sub};
  }
}

class CreditCardModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<CreditCard> _results;

  CreditCardModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<CreditCard> _temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _temp.add(CreditCard(parsedJson['results'][i]));
    }
    _results = _temp;
  }

  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<CreditCard> get results => _results;
}

class CreditCard {
  late int _id;
  late String _number;
  late String _name;
  late String _month;
  late String _year;
  late String _password;

  CreditCard(result) {
    _id = result['id'];
    _number = result['number'];
    _name = result['name'];
    _month = result['month'];
    _year = result['year'];
    _password = result['password'];
  }

  int get id => _id;
  String get number => _number;
  String get name => _name;
  String get month => _month;
  String get year => _year;
  String get password => _password;
}

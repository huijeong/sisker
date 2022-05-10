class AddressModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<Address> _results;

  AddressModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<Address> _temp = [];
    print('CartModel fromJson => ${parsedJson}');
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Address _item = Address(parsedJson['results'][i]);
      _temp.add(_item);
    }
    _results = _temp;
  }

  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<Address> get results => _results;
}

class Address {
  late String _id;
  late String _full_name;
  late String _phone;
  late String _email;
  late String _postcode;
  late String _address_line;
  late String _address_line2;
  late String _town_city;
  late String _county;

  Address(result) {
    _id = result['id'];
    _full_name = result['full_name'];
    _phone = result['phone'];
    _email = result['email'];
    _postcode = result['postcode'];
    _address_line = result['address_line'];
    _address_line2 = result['address_line2'];
    _town_city = result['town_city'];
    _county = result['county'];
  }

  String get id => _id;
  String get full_name => _full_name;
  String get phone => _phone;
  String get email => _email;
  String get postcode => _postcode;
  String get address_line => _address_line;
  String get address_line2 => _address_line2;
  String get town_city => _town_city;
  String get county => _county;
}
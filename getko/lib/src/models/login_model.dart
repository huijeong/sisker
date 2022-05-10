class LoginModel {
  late String _key;
  late _UserModel _user;

  LoginModel.fromJson(Map<String, dynamic> parsedJson) {
    _key = parsedJson['key'];
    _user = _UserModel(parsedJson['user']);
  }

  _UserModel get user => _user;
  String get key => _key;
}

class _UserModel {
  late int _id;
  late String _username;
  late String _register_type;
  late String? _name;
  late String? _email;
  late String? _mobile;
  late String? _device_id;

  _UserModel(result) {
    _id = result['id'];
    _username = result['username'];
    _register_type = result['register_type'];
    _name = result['name'];
    _email = result['email'];
    _mobile = result['mobile'];
    _device_id = result['device_id'];
  }
  int get id => _id;
  String get username => _username;
  String get register_type => _register_type;
  String? get name => _name;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get device_id => _device_id;
}

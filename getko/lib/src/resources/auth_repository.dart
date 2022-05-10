import 'dart:async';
import 'package:getko/src/resources/auth_api_provider.dart';
import 'package:getko/src/models/login_model.dart';

class AuthRepository {
  final _authApiProvider = AuthApiProvider();

  Future<LoginModel> login() => _authApiProvider.login();
}

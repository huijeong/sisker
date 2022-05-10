import 'package:rxdart/rxdart.dart';
import 'package:getko/src/models/login_model.dart';
import 'package:getko/src/resources/auth_repository.dart';

class AuthBloc {
  final _repository = AuthRepository();
  final _authFetcher = BehaviorSubject<LoginModel>();

  login() async {
    try {
      LoginModel _loginModel = await _repository.login();
      _authFetcher.sink.add(_loginModel);
    } on Exception catch (ex) {
      print('login() Exception => $ex');
    } catch (error) {
      print('login() Error => $error');
    }
  }

  dispose() {
    _authFetcher.close();
  }

  BehaviorSubject<LoginModel> get authFetcher => _authFetcher;
}

final auth_bloc = AuthBloc();

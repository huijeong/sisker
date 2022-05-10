import 'package:rxdart/rxdart.dart';
import 'package:getko/src/models/credit_card_model.dart';
import 'package:getko/src/models/address_model.dart';
import 'package:getko/src/resources/user_repository.dart';

class UserBloc {
  final _repository = UserRepository();
  final _cardListFetcher = BehaviorSubject<CreditCardModel>();
  final _cardAddFetcher = BehaviorSubject<CreditCardModel>();
  final _cardDeleteFetcher = BehaviorSubject<CreditCardModel>();

  final _addressListFetcher = BehaviorSubject<AddressModel>();
  final _addressAddFetcher = BehaviorSubject<AddressModel>();
  final _addressDeleteFetcher = BehaviorSubject<AddressModel>();

  listCreditCard() async {
    try {
      CreditCardModel _cartModel = await _repository.listCreditCard();
      _cardListFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('listCreditCard() Exception => $ex');
    } catch (error) {
      print('listCreditCard() Error => $error');
    }
  }

  addCreditCard(String number, String month, String year, String password,
      String name) async {
    try {
      CreditCardModel _cartModel =
          await _repository.addCreditCard(number, month, year, password, name);
      _cardAddFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('addCreditCard() Exception => $ex');
    } catch (error) {
      print('addCreditCard() Error => $error');
    }
  }

  deleteCreditCard(int cartId) async {
    try {
      CreditCardModel _cartModel = await _repository.deleteCreditCard(cartId);
      _cardDeleteFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('deleteCreditCard() Exception => $ex');
    } catch (error) {
      print('deleteCreditCard() Error => $error');
    }
  }

  listAddress() async {
    try {
      AddressModel _cartModel = await _repository.listAddress();
      _addressListFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('listAddress() Exception => $ex');
    } catch (error) {
      print('listAddress() Error => $error');
    }
  }

  addAddress(
      String full_name,
      String phone,
      String email,
      String postcode,
      String address_line,
      String address_line2,
      String town_city,
      String country) async {
    try {
      AddressModel _cartModel = await _repository.addAddress(full_name, phone,
          email, postcode, address_line, address_line2, town_city, country);
      _addressAddFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('addAddress() Exception => $ex');
    } catch (error) {
      print('addAddress() Error => $error');
    }
  }

  deleteAddress(String cartId) async {
    try {
      AddressModel _cartModel = await _repository.deleteAddress(cartId);
      _addressDeleteFetcher.sink.add(_cartModel);
    } on Exception catch (ex) {
      print('deleteAddress() Exception => $ex');
    } catch (error) {
      print('deleteAddress() Error => $error');
    }
  }

  dispose() {
    _cardListFetcher.close();
    _cardAddFetcher.close();
    _cardDeleteFetcher.close();

    _addressListFetcher.close();
    _addressAddFetcher.close();
    _addressDeleteFetcher.close();
  }

  BehaviorSubject<CreditCardModel> get cardListFetcher => _cardListFetcher;
  BehaviorSubject<CreditCardModel> get cardAddFetcher => _cardAddFetcher;
  BehaviorSubject<CreditCardModel> get cardDeleteFetcher => _cardDeleteFetcher;

  BehaviorSubject<AddressModel> get addressListFetcher => _addressListFetcher;
  BehaviorSubject<AddressModel> get addressAddFetcher => _addressAddFetcher;
  BehaviorSubject<AddressModel> get addressDeleteFetcher =>
      _addressDeleteFetcher;
}

final user_bloc = UserBloc();

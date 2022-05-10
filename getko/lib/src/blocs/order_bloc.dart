import 'package:rxdart/rxdart.dart';
import 'package:getko/src/resources/order_repository.dart';
import 'package:getko/src/models/orders_model.dart';

class OrderBloc {
  final _repository = OrderRepository();
  final _orderListFetcher = BehaviorSubject<OrderModel>();
  final _orderAddFetcher = BehaviorSubject<OrderModel>();

  list() async {
    OrderModel _orderModel = await _repository.list();
    _orderListFetcher.sink.add(_orderModel);
  }

  add(
      String address_id,
      String payment_card,
      String full_name,
      String email,
      String address1,
      String address2,
      String phone,
      String postal_code) async {
    try {
      OrderModel _orderModel = await _repository.add(address_id, payment_card,
          full_name, email, address1, address2, phone, postal_code);
      _orderAddFetcher.sink.add(_orderModel);
    } on Exception catch (ex) {
      print('add() Exception => $ex');
    } catch (error) {
      print('add() Error => $error');
    }
  }

  dispose() {
    _orderListFetcher.close();
    _orderAddFetcher.close();
  }

  BehaviorSubject<OrderModel> get orderListFetcher => _orderListFetcher;
  BehaviorSubject<OrderModel> get orderAddFetcher => _orderAddFetcher;
}

final order_bloc = OrderBloc();

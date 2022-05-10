import 'package:rxdart/rxdart.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/models/home_top_product_model.dart';
import 'package:getko/src/resources/home_repository.dart';

class HomeBloc {
  final _repository = HomeRepository();
  final _homeRecommendFetcher = BehaviorSubject<HomeRecommendModel>();
  final _homeTopFetcher = BehaviorSubject<HomeTopModel>();

  recommend() async {
    try {
      HomeRecommendModel _homeRecommendModel = await _repository.recommend();
      _homeRecommendFetcher.sink.add(_homeRecommendModel);
    } on Exception catch (ex) {
      print('recommend() Exception => $ex');
    } catch (error) {
      print('recommend() Error => $error');
    }
  }

  top() async {
    try {
      HomeTopModel _homeTopModel = await _repository.top();
      _homeTopFetcher.sink.add(_homeTopModel);
    } on Exception catch (ex) {
      print('top() Exception => $ex');
    } catch (error) {
      print('top() Error => $error');
    }
  }

  dispose() {
    _homeRecommendFetcher.close();
    _homeTopFetcher.close();
  }

  BehaviorSubject<HomeRecommendModel> get homeRecommendFetcher =>
      _homeRecommendFetcher;

  BehaviorSubject<HomeTopModel> get homeTopFetcher => _homeTopFetcher;
}

final home_bloc = HomeBloc();

import 'dart:async';
import 'package:getko/src/resources/home_api_provider.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/models/home_top_product_model.dart';
import 'package:getko/src/ui/main/components/recommended_list.dart';

class HomeRepository {
  final _homeApiProvider = HomeApiProvider();

  Future<HomeRecommendModel> recommend() => _homeApiProvider.recommend();

  Future<HomeTopModel> top() => _homeApiProvider.top();
}

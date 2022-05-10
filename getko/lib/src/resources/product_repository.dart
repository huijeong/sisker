import 'dart:async';
import 'package:getko/src/resources/product_api_provider.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/top_keyword_category_model.dart';
import 'package:getko/src/ui/product/components/product_options.dart';

class ProductRepository {
  final _productApiProvider = ProductApiProvider();

  Future<SearchProductModel> search(String keyword) =>
      _productApiProvider.search(keyword);

  Future<ProductOptionModel> option(String productNo) =>
      _productApiProvider.option(productNo);

  Future<TopKeywordCategoryModel> topKeyword() =>
      _productApiProvider.topKeyword();
}

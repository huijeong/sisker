import 'package:rxdart/rxdart.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/resources/product_repository.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/models/top_keyword_category_model.dart';

class ProductBloc {
  final _repository = ProductRepository();
  final _searchProductFetcher = BehaviorSubject<SearchProductModel>();
  final _productOptionFetcher = BehaviorSubject<ProductOptionModel>();
  final _topKeywordFetcher = BehaviorSubject<TopKeywordCategoryModel>();

  search(String keyword) async {
    try {
      SearchProductModel _searchProductModel =
          await _repository.search(keyword);
      _searchProductFetcher.sink.add(_searchProductModel);
    } on Exception catch (ex) {
      print('search() Exception => $ex');
    } catch (error) {
      print('search() Error => $error');
    }
  }

  option(String productNo) async {
    try {
      ProductOptionModel _productOptionModel =
          await _repository.option(productNo);
      _productOptionFetcher.sink.add(_productOptionModel);
    } on Exception catch (ex) {
      print('option() Exception => $ex');
    } catch (error) {
      print('option() Error => $error');
    }
  }

  topKeyword() async {
    try {
      TopKeywordCategoryModel _topKeywordModel = await _repository.topKeyword();
      _topKeywordFetcher.sink.add(_topKeywordModel);
    } on Exception catch (ex) {
      print('topKeyword() Exception => $ex');
    } catch (error) {
      print('topKeyword() Error => $error');
    }
  }

  dispose() {
    _searchProductFetcher.close();
    _productOptionFetcher.close();
    _topKeywordFetcher.close();
  }

  BehaviorSubject<SearchProductModel> get searchProductFetcher =>
      _searchProductFetcher;
  BehaviorSubject<ProductOptionModel> get productOptionFetcher =>
      _productOptionFetcher;
  BehaviorSubject<TopKeywordCategoryModel> get topKeywordFetcher =>
      _topKeywordFetcher;
}

final product_bloc = ProductBloc();

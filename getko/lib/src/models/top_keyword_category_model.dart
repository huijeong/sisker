class TopKeywordCategoryModel {
  late int _count;
  late String _next;
  late String _previous;
  late List<TopKeywordCategory> _results;

  TopKeywordCategoryModel.fromJson(Map<String, dynamic> parsedJson) {
    _count = parsedJson['count'];
    _next = parsedJson['next'];
    _previous = parsedJson['previous'];
    List<TopKeywordCategory> temp = [];
    // print('results => ${parsedJson['results']}');
    for (int i = 0; i < parsedJson['results'].length; i++) {
      // print('result $i => ${parsedJson['results'][i]}');
      TopKeywordCategory category =
          TopKeywordCategory(parsedJson['results'][i]);
      // print('searchProduct => $category');
      temp.add(category);
    }
    _results = temp;
  }
  int get count => _count;
  String get next => _next;
  String get previous => _previous;
  List<TopKeywordCategory> get results => _results;
}

class TopKeywordCategory {
  late String _name;
  late int _ordering;
  late bool _is_active;
  late List<TopKeyword> _related_top_keyword;

  TopKeywordCategory(result) {
    _name = result['name'];
    _ordering = result['ordering'];
    _is_active = result['is_active'];
    List<TopKeyword> _temp = [];
    for (int i = 0; i < result['related_top_keyword'].length; i++) {
      _temp.add(TopKeyword(result['related_top_keyword'][i]));
    }
    _related_top_keyword = _temp;
  }
  String get name => _name;
  int get ordering => _ordering;
  bool get is_active => _is_active;
  List<TopKeyword> get related_top_keyword => _related_top_keyword;
}

class TopKeyword {
  late String _start_date;
  late String _end_date;
  late String _keyword;
  late int _ordering;

  TopKeyword(result) {
    _start_date = result['start_date'];
    _end_date = result['end_date'];
    _keyword = result['keyword']['keyword'];
    _ordering = result['ordering'];
  }

  String get start_date => _start_date;
  String get end_date => _end_date;
  String get keyword => _keyword;
  int get ordering => _ordering;

  @override
  String toString() {
    return "$_start_date / $_end_date / $_keyword";
  }
}

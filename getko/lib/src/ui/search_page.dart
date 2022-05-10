import 'dart:async';

import 'package:getko/src/blocs/home_bloc.dart';
import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/product/view_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rubber/rubber.dart';
import 'package:getko/src/blocs/product_bloc.dart';
import 'package:getko/src/models/search_product_model.dart';
import 'package:getko/src/models/top_keyword_category_model.dart';

class SearchPage extends StatefulWidget {
  int? fromMain = 0; // 0: main tab bar, 1: from icon

  SearchPage({Key? key, this.fromMain}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState(this.fromMain);
}

late StreamSubscription _productSubscription;
late StreamSubscription _topKeywordSubscription;

class Category {
  String name;
  List<String> keywords;

  Category(this.name, this.keywords);
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";

  String searchKeyword = "";

  int? fromMain = 0;
  _SearchPageState(this.fromMain);

  List<Product> products = [
    Product(
        'assets/headphones_2.png',
        'Skullcandy headset L325',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
        102.99,
        ''),
    Product(
        'assets/headphones_3.png',
        'Skullcandy headset X25',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
        55.99,
        ''),
    Product(
        'assets/headphones.png',
        'Blackzy PRO hedphones M003',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
        152.99,
        ''),
  ];

  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<String> priceFilter = [
    '\$50-200',
    '\$200-400',
    '\$400-800',
    '\$800-1000',
  ];

  List<Category> categories = [];

  List<Product> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;
  List<Widget> topKeywordListView = [];

  @override
  void initState() {
    super.initState();
    product_bloc.topKeyword();
    searchResults.clear();

    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));

    _productSubscription =
        product_bloc.searchProductFetcher.stream.listen((event) {
      // print('product_bloc productSubscription => ${event.results}');
      List<Product> _temp = [];
      for (int i = 0; i < event.results.length; i++) {
        SearchProduct prd = event.results[i];
        _temp.add(Product(prd.product_thumbnail, prd.title, prd.title,
            prd.regular_price, prd.product_url, prd.product_no));
      }
      setState(() {
        searchResults.clear();
        searchResults.addAll(_temp);
      });
    });

    _topKeywordSubscription =
        product_bloc.topKeywordFetcher.stream.listen((event) {
      print('product_bloc topKeyword listen $event');
      List<Category> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        List<String> _temps2 = [];
        for (int j = 0; j < event.results[i].related_top_keyword.length; j++) {
          _temps2.add(event.results[i].related_top_keyword[j].keyword);
        }
        _temps.add(Category(event.results[i].name, _temps2));
      }
      setState(() {
        categories = _temps;
        reloadTopKeywordListView();
      });
      // reloadTopKeywordListView();
    });
  }

  void reloadTopKeywordListView() {
    topKeywordListView.add(Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Pouplar Keyword',
          style: TextStyle(color: Colors.grey[300]),
        ),
      ),
    ));

    for (int i = 0; i < categories.length; i++) {
      List<String> keywords = categories[i].keywords;
      print(' reloadTopKeywordListView => $i, ${keywords}');
      topKeywordListView.add(Container(
        height: 50,
        child: ListView.builder(
          itemBuilder: (_, index) => Center(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: InkWell(
                onTap: () {
                  setState(() {
                    // selectedPeriod = keywords[index];
                    searchController.text = keywords[index];
                    searchKeyword = keywords[index];
                  });
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                    decoration: selectedPeriod == keywords[index]
                        ? BoxDecoration(
                            color: Color(0xffFDB846),
                            borderRadius: BorderRadius.all(Radius.circular(45)))
                        : BoxDecoration(),
                    child: Text(
                      '#${keywords[index]}',
                      style: TextStyle(fontSize: 16.0),
                    ))),
          )),
          itemCount: keywords.length,
          scrollDirection: Axis.horizontal,
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    // product_bloc.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                fromMain == 1
                    ? CloseButton(
                        onPressed: () {
                          // if (fromMain == 1) {
                          Navigator.of(context).pop(null);
                          // }
                        },
                      )
                    : Container()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.orange, width: 1))),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    searchKeyword = value;
                  });
                  // List<Product> tempList = [];
                  // products.forEach((product) {
                  //   if (product.name.toLowerCase().contains(value)) {
                  //     tempList.add(product);
                  //   }
                  // });
                  // setState(() {
                  //   searchResults.clear();
                  //   searchResults.addAll(tempList);
                  // });
                  return;
                } else {
                  // setState(() {
                  //   searchResults.clear();
                  //   searchResults.addAll(products);
                  // });
                }
              },
              cursorColor: darkGrey,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  prefixIcon: SvgPicture.asset(
                    'assets/icons/search_icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  suffix: FlatButton(
                      onPressed: () {
                        // searchController.clear();
                        // searchResults.clear();
                        print('searchKeyword => $searchKeyword');
                        product_bloc.search(searchKeyword);
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.red),
                      ))),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange[50],
              child: ListView.builder(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: searchResults.length,
                  itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ViewProductPage(
                                      product: searchResults[index],
                                    ))),
                        title: Text(searchResults[index].name),
                      ))),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
//          controller: _scrollController,
        children: topKeywordListView,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
            body: RubberBottomSheet(
          lowerLayer: _getLowerLayer(), // The underlying page (Widget)
          upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
          animationController: _controller, // The one we created earlier
        )),
      ),
    );
  }
}

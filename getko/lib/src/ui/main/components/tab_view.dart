import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/category.dart';
import 'package:flutter/material.dart';
import 'category_card.dart';
import 'recommended_list.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';

class TabView extends StatefulWidget {
  TabView({Key? key, required this.tabController, required this.categories})
      : super(key: key);

  List<RecommendCategory> categories;
  final TabController tabController;

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  // List<Category> categories;

  List<Widget> makeRecommendList() {
    List<Widget> recommendListWidget = [];
    for (RecommendCategory category in widget.categories) {
      // print('for loop => $category');

      recommendListWidget.add(
        Column(children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          Flexible(
              child:
                  RecommendedList(products: category.related_recommend_product))
        ]),
      );
    }

    return recommendListWidget;
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: widget.tabController,
        children: makeRecommendList());
  }

  // Widget build2(BuildContext context) {
  //   // print(MediaQuery.of(context).size.height / 9);
  //   return TabBarView(
  //       physics: NeverScrollableScrollPhysics(),
  //       controller: tabController,
  //       children: <Widget>[
  //         Container(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               // Container(
  //               //     margin: EdgeInsets.all(8.0),
  //               //     height: MediaQuery.of(context).size.height / 9,
  //               //     width: MediaQuery.of(context).size.width,
  //               //     child: ListView.builder(
  //               //         scrollDirection: Axis.horizontal,
  //               //         itemCount: categories.length,
  //               //         itemBuilder: (_, index) => CategoryCard(
  //               //               category: categories[index],
  //               //             ))),
  //               SizedBox(
  //                 height: 16.0,
  //               ),
  //               Flexible(child: RecommendedList()),
  //             ],
  //           ),
  //         ),
  //         Column(children: <Widget>[
  //           SizedBox(
  //             height: 16.0,
  //           ),
  //           Flexible(child: RecommendedList())
  //         ]),
  //         Column(children: <Widget>[
  //           SizedBox(
  //             height: 16.0,
  //           ),
  //           Flexible(child: RecommendedList())
  //         ]),
  //         Column(children: <Widget>[
  //           SizedBox(
  //             height: 16.0,
  //           ),
  //           Flexible(child: RecommendedList())
  //         ]),
  //         Column(children: <Widget>[
  //           SizedBox(
  //             height: 16.0,
  //           ),
  //           Flexible(child: RecommendedList())
  //         ]),
  //       ]);
  // } // end of Widget build

}

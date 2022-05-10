import 'dart:async';

import 'package:getko/src/models/home_top_product_model.dart';
import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/ui/custom_background.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/shop/check_out_page.dart';
import 'package:getko/src/ui/auth/profile_page.dart';
import 'package:getko/src/ui/category/category_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';
import 'package:getko/src/models/category.dart';
import 'package:getko/src/blocs/home_bloc.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/ui/search_page.dart';
import 'package:getko/src/ui/orders/order_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

late StreamSubscription _subscription;
late StreamSubscription _subscription2;

// List<String> timelines = ['Weekly featured', 'Best of June', 'Best of 2018'];

class RecommendColor {
  Color startColor;
  Color endColor;

  RecommendColor(this.startColor, this.endColor);
}

List<RecommendColor> recommendColors = [
  RecommendColor(Color(0xffFCE183), Color(0xffF68D7F)),
  RecommendColor(Color(0xffF749A2), Color(0xffFF7375)),
  RecommendColor(Color(0xff00E9DA), Color(0xff5189EA)),
  RecommendColor(Color(0xffAF2D68), Color(0xff632376)),
  RecommendColor(Color(0xff36E892), Color(0xff33B2B9)),
  RecommendColor(Color(0xffF123C4), Color(0xff668CEA))
];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late SwiperController swiperController;
  late TabController tabController;
  late TabController bottomTabController;
  late Widget tabBar;
  List<RecommendCategory> categories = [];
  List<Tab> categoryHeaders = [];

  String selectedTimeline = 'Weekly featured';
  // String selectedCategory = '';
  List<Widget> topCategories = [];
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    bottomTabController = TabController(length: 4, vsync: this);
    tabController = TabController(length: categories.length, vsync: this);

    home_bloc.recommend();
    _subscription = home_bloc.homeRecommendFetcher.stream.listen((event) {
      print('home_bloc subscription => $event');
      categories = event.recommend_categories;
      List<Tab> _temp = [];
      // make categories
      for (int i = 0; i < event.recommend_categories.length; i++) {
        // event.recommend_categories[i].name;
        print('category => ${event.recommend_categories[i].name}');

        _temp.add(Tab(text: event.recommend_categories[i].name));
      }
      setState(() {
        categoryHeaders = _temp;
        tabController = TabController(length: categories.length, vsync: this);
      });

      // makeTabBar();
    }); // end of subscription

    home_bloc.top();
    _subscription2 = home_bloc.homeTopFetcher.stream.listen((event) {
      print('home_bloc subscription2 => $event');
      setState(() {
        topCategories = makeTopHeader(event);
      });
    }); // end of subscription2
  } // end of initState

  Widget headerTitle = Container();

  List<Widget> makeTopHeader(HomeTopModel model) {
    List<Widget> _temp = [];
    for (int i = 0; i < model.top_categories.length; i++) {
      if (i == 0) {
        selectedTimeline = model.top_categories[i].name;

        List<Product> _tempProduct = [];
        for (int j = 0;
            j < model.top_categories[i].related_top_product.length;
            j++) {
          HomeProduct hp =
              model.top_categories[i].related_top_product[j].product;
          _tempProduct.add(Product(hp.product_thumbnail, hp.title, hp.title,
              hp.regular_price, hp.product_url, hp.product_no));
        }
        products = _tempProduct;
      }
      _temp.add(Flexible(
        child: InkWell(
          onTap: () {
            setState(() {
              List<Product> _tempProduct = [];
              for (int j = 0;
                  j < model.top_categories[i].related_top_product.length;
                  j++) {
                HomeProduct hp =
                    model.top_categories[i].related_top_product[j].product;
                _tempProduct.add(Product(hp.product_thumbnail, hp.title,
                    hp.title, hp.regular_price, hp.product_url, hp.product_no));
              }
              selectedTimeline = model.top_categories[i].name;
              products = _tempProduct;
            });
          },
          child: Text(
            model.top_categories[i].name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize:
                    model.top_categories[i].name == selectedTimeline ? 16 : 16,
                color: darkGrey),
          ),
        ),
      ));
    }

    return _temp;
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
          // Text(
          //   "Sisker",
          //   style: TextStyle(
          //     color: darkGrey,
          //     fontFamily: "Montserrat",
          //     fontWeight: FontWeight.bold,
          //     fontSize: 20,
          //   ),
          // ),
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SearchPage(
                        fromMain: 1,
                      ))),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: topCategories));

    tabBar = TabBar(
      tabs: categoryHeaders,
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: appBar,
                    ),
                    SliverToBoxAdapter(
                      child: topHeader,
                    ),
                    SliverToBoxAdapter(
                      child: ProductList(
                        products: products,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: tabBar,
                    )
                  ];
                },
                body: TabView(
                  tabController: tabController,
                  categories: categories,
                ),
              ),
            ),
            // CategoryListPage(),
            // OrderPage(),
            SearchPage(),
            CheckOutPage(),
            ProfilePage()
          ],
        ),
      ),
    );
  }
}

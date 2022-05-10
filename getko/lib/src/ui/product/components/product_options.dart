import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
// import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'shop_bottomSheet.dart';
import 'package:getko/src/blocs/cart_bloc.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/ui/product/view_product_page.dart';

class ProductOption extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Product product;
  final ProductOptionModel options;
  final DropDownItem selectedFirstOption;
  final DropDownItem selectedSecondOption;
  final DropDownItem selectedThirdOption;
  final DropDownItem selectedForthOption;

  const ProductOption(this.scaffoldKey,
      {Key? key,
      required this.product,
      required this.options,
      required this.selectedFirstOption,
      required this.selectedSecondOption,
      required this.selectedThirdOption,
      required this.selectedForthOption})
      : super(key: key);

  @override
  _ProductOptionState createState() => _ProductOptionState(
      scaffoldKey,
      product,
      options,
      selectedFirstOption,
      selectedSecondOption,
      selectedThirdOption,
      selectedForthOption);
}

late StreamSubscription _cartAddSubscription;
late StreamSubscription _cartDeleteSubscription;

class _ProductOptionState extends State<ProductOption>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Product product;
  final ProductOptionModel options;
  final DropDownItem selectedFirstOption;
  final DropDownItem selectedSecondOption;
  final DropDownItem selectedThirdOption;
  final DropDownItem selectedForthOption;

  List<Product> cartItems = [];

  _ProductOptionState(
      this.scaffoldKey,
      this.product,
      this.options,
      this.selectedFirstOption,
      this.selectedSecondOption,
      this.selectedThirdOption,
      this.selectedForthOption);

  late AnimationController controller;

  Widget getImage(String name) {
    if (name.contains("http")) {
      return Image.network(product.image, height: 180, width: 180);
    }
    return Image.asset(
      product.image,
      height: 180,
      width: 180,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = Duration(seconds: 0);

    _cartAddSubscription = cart_bloc.cartAddFetcher.stream.listen((event) {
      print('cart_bloc add subscription => $event, ${event.results}');
      List<Product> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        // print(
        //     'for event.result $i, ${event.results[i].product} | ${event.results[i].id}');
        HomeProduct _product = event.results[i].product;
        _temps.add(Product(
            _product.product_thumbnail,
            _product.title,
            _product.title,
            double.parse(event.results[i].price),
            _product.product_thumbnail,
            event.results[i].id.toString()));
      }
      setState(() {
        // products = _temps;
        cartItems = _temps;
        print('setState cartItems => $cartItems');
        // scaffoldKey.currentState!.showBottomSheet((context) {
        //   return ShopBottomSheet(products: cartItems, callback: deleteCartItem);
        // });
        showBottomSheet(
            context: context,
            transitionAnimationController: controller,
            builder: (context) {
              return ShopBottomSheet(
                  products: cartItems, callback: deleteCartItem);
            });
      });
    });

    _cartDeleteSubscription =
        cart_bloc.cartDeleteFetcher.stream.listen((event) {
      print('cart_bloc delete subscription => $event, ${event.results}');
      List<Product> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        // print('for event.result $i, ${event.results[i].product}');
        HomeProduct _product = event.results[i].product;
        _temps.add(Product(
            _product.product_thumbnail,
            _product.title,
            _product.title,
            double.parse(event.results[i].price),
            _product.product_thumbnail,
            event.results[i].id.toString()));
      }
      setState(() {
        // products = _temps;
        cartItems = _temps;
        print('setState cartItems => $cartItems');
        // scaffoldKey.currentState!.showBottomSheet((context, {train}) {
        //   return Container();
        // });
        // scaffoldKey.currentState!.showBottomSheet((context) {
        //   return ShopBottomSheet(products: cartItems, callback: deleteCartItem);
        // });
        showBottomSheet(
            context: context,
            transitionAnimationController: controller,
            builder: (context) {
              return ShopBottomSheet(
                  products: cartItems, callback: deleteCartItem);
            });
      });
    });
  }

  void deleteCartItem(int _id) {
    cart_bloc.delete(_id);
  }

  void addCartItem() {
    String item = this.selectedFirstOption.name +
        ' / ' +
        this.selectedSecondOption.name +
        ' / ' +
        this.selectedThirdOption.name +
        ' / ' +
        this.selectedForthOption.name;
    print('onTap =>  $options | ${this.selectedFirstOption}');
    cart_bloc.add(product.id!, options, product.price.round(), 1, item);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 16.0,
            top: 32.0,
            child: getImage(product.image),
          ),
          Positioned(
            right: 0.0,
            child: Container(
              height: 180,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(product.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            shadows: shadow)),
                  ),
                  InkWell(
                    onTap: () async {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CheckOutPage()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: mainButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // cart_bloc.list();
                      // scaffoldKey.currentState!.showBottomSheet((context) {
                      //   return ShopBottomSheet();
                      // });
                      addCartItem();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          gradient: mainButton,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: file_names, prefer_const_constructors
import 'dart:async';

import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/shop/check_out_page.dart';
import 'package:flutter/material.dart';

import 'shop_product.dart';

class ShopBottomSheet extends StatefulWidget {
  final List<Product> products;
  final Function callback;
  ShopBottomSheet({Key? key, required this.products, required this.callback})
      : super(key: key);
  @override
  _ShopBottomSheetState createState() =>
      _ShopBottomSheetState(this.products, this.callback);
}

// late StreamSubscription _cartListSubscription;

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  List<Product> products = [
    // Product('assets/headphones.png',
    //     'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 45.3),
    // Product('assets/headphones_2.png',
    //     'Boat roackerz 100 On-Ear Bluetooth Headphones', 'description', 22.3),
    // Product('assets/headphones_3.png',
    //     'Boat roackerz 300 On-Ear Bluetooth Headphones', 'description', 58.3)
  ];
  Function callback;
  _ShopBottomSheetState(this.products, this.callback);

  @override
  Widget build(BuildContext context) {
    print('_ShopBottomSheetState products => $products');
    Widget confirmButton = InkWell(
      onTap: () async {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => CheckOutPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom == 0
                ? 20
                : MediaQuery.of(context).padding.bottom),
        child: Center(
            child: Text("Confirm",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0))),
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
      ),
    );

    return Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Image.asset(
                  'assets/box.png',
                  height: 24,
                  width: 24.0,
                  fit: BoxFit.cover,
                ),
                onPressed: () {},
                iconSize: 48,
              ),
            ),
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    return Row(
                      children: <Widget>[
                        ShopProduct(
                          products[index],
                          onRemove: () {
                            // setState(() {
                            //   products.remove(products[index]);
                            // });
                            print('onRemove => ${products[index]}');
                            this.callback(int.parse(products[index].id!));
                          },
                        ),
                        index == 4
                            ? SizedBox()
                            : Container(
                                width: 2,
                                height: 200,
                                color: Color.fromRGBO(100, 100, 100, 0.1))
                      ],
                    );
                  }),
            ),
            confirmButton
          ],
        ));
  }
}

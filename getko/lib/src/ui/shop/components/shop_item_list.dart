import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/product/components/color_list.dart';
import 'package:getko/src/ui/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class ShopItemList extends StatefulWidget {
  final Product product;
  final Function onRemove;
  final Function onUpdate;

  ShopItemList(this.product,
      {Key? key, required this.onRemove, required this.onUpdate})
      : super(key: key);

  @override
  _ShopItemListState createState() =>
      _ShopItemListState(this.product, this.onRemove, this.onUpdate);
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;
  final Product product;
  final Function onRemove;
  final Function onUpdate;

  _ShopItemListState(this.product, this.onRemove, this.onUpdate);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, 0.8),
            child: Container(
                height: 100,
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadow,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12.0, right: 12.0),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.product.name,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: darkGrey,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 160,
                                padding: const EdgeInsets.only(
                                    left: 32.0, top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    // ColorOption(Colors.red),
                                    Text(
                                      '\$${widget.product.price}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: darkGrey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
//TODO: Work on scroll quantity
                      Theme(
                        data: ThemeData(
                            accentColor: Colors.black,
                            textTheme: TextTheme(
                              headline1: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              bodyText2: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                color: Colors.grey[400],
                              ),
                            )),
                        child: NumberPicker(
                          value: quantity,
                          minValue: 1,
                          maxValue: 10,
                          onChanged: (value) {
                            setState(() {
                              quantity = value;
                              onUpdate(int.parse(product.id!), value);
                            });
                          },
                          // itemExtent: 30,
                          // listViewWidth: 40,
                        ),
                      )
                    ])),
          ),
          Positioned(
              top: 35,
              child: ShopProductDisplay(
                widget.product,
                onPressed: onRemove,
              )),
        ],
      ),
    );
  }
}

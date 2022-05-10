import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/order.dart';
import 'package:getko/src/ui/product/components/color_list.dart';
import 'package:getko/src/ui/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class OrderItemList extends StatefulWidget {
  final List<PayOrderItem> items;

  OrderItemList({required this.items, Key? key}) : super(key: key);

  @override
  _OrderItemListState createState() => _OrderItemListState(this.items);
}

class _OrderItemListState extends State<OrderItemList> {
  int quantity = 1;
  final List<PayOrderItem> items;

  _OrderItemListState(this.items);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.orange[50],
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 100,
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
                                      padding: EdgeInsets.only(
                                          top: 12.0, right: 12.0),
                                      width: 300,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            items[index].productName,
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
                                              width: 200,
                                              padding: const EdgeInsets.only(
                                                  left: 32.0,
                                                  top: 8.0,
                                                  bottom: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '${items[index].seller}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: darkGrey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    '${items[index].price}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: darkGrey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  ),
                                                  Text(
                                                    '${items[index].quantity}',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: darkGrey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.0),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ])),
                        ),
                        Positioned(
                            top: 35,
                            child: ShopProductDisplay(
                              item: items[index],
                            )),
                      ],
                    ),
                  );
                })));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final PayOrderItem item;

  const ShopProductDisplay({required this.item, Key? key}) : super(key: key);

  Widget getImage(String image) {
    if (image.contains("http")) {
      return Image.network(image, fit: BoxFit.contain);
    } else {
      return Image.asset(image, fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 150,
      child: Stack(children: <Widget>[
        Positioned(
          left: 50,
          top: 5,
          child: SizedBox(
              height: 60, width: 60, child: getImage(item.productImage)),
        )
      ]),
    );
  }
}

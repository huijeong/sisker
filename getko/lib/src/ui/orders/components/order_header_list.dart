import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/product/components/color_list.dart';
import 'package:getko/src/ui/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:getko/src/models/order.dart';

class OrderHeaderList extends StatefulWidget {
  final PayOrder order;
  OrderHeaderList({Key? key, required this.order}) : super(key: key);
  @override
  _OrderHeaderListState createState() => _OrderHeaderListState(this.order);
}

class _OrderHeaderListState extends State<OrderHeaderList> {
  final PayOrder order;

  _OrderHeaderListState(this.order);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      height: 48.0,
      color: yellow,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Order No : ${order.orderNo}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
          ),
          Text(
            ' ${order.orderStatus}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
          ),
          Text(
            ' ${order.orderDate}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
          )
        ],
      ),
    );
  }
}

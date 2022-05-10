import 'dart:async';

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:getko/src/ui/app_properties.dart';
import 'package:flutter/cupertino.dart';

import 'package:getko/src/models/order.dart';
import 'package:getko/src/blocs/order_bloc.dart';
import 'package:getko/src/models/orders_model.dart';
import 'components/order_header_list.dart';
import 'components/order_item_list.dart';
import 'package:intl/intl.dart';
import 'package:getko/src/ui/main/main_page.dart';

class OrderPage extends StatefulWidget {
  // final List<PayOrder> orders;

  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

late StreamSubscription _orderListSubscription;
late StreamSubscription _orderAddSubscription;

class _OrderPageState extends State<OrderPage> {
  List<PayOrder> orders = [];
  bool toMain = false;
  // _OrderPageState();
  Widget orderedList = Container();

  @override
  void initState() {
    print('initState...');
    order_bloc.list();
    _orderListSubscription = order_bloc.orderListFetcher.stream.listen((event) {
      print('order_bloc list subscription => $event');

      List<PayOrder> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        List<PayOrderItem> _temp_items = [];
        for (int j = 0; j < event.results[i].items.length; j++) {
          _temp_items.add(PayOrderItem(
              event.results[i].items[j].title,
              event.results[i].items[j].product_thumbnail,
              event.results[i].items[j].price,
              event.results[i].items[j].quantity.toString(),
              event.results[i].items[j].seller));
        }
        _temps.add(PayOrder(
            event.results[i].id.toString(),
            event.results[i].total_paid,
            DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(event.results[i].created)),
            _temp_items,
            event.results[i].order_status));
      }

      setState(() {
        orders = _temps;
        reloadListView();
      });
    });

    _orderAddSubscription = order_bloc.orderAddFetcher.stream.listen((event) {
      print('order_bloc add subscription => $event');

      List<PayOrder> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        List<PayOrderItem> _temp_items = [];
        for (int j = 0; j < event.results[i].items.length; j++) {
          _temp_items.add(PayOrderItem(
              event.results[i].items[j].title,
              event.results[i].items[j].product_thumbnail,
              event.results[i].items[j].price,
              event.results[i].items[j].quantity.toString(),
              event.results[i].items[j].seller));
        }
        _temps.add(PayOrder(
            event.results[i].id.toString(),
            event.results[i].total_paid,
            DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(event.results[i].created)),
            _temp_items,
            event.results[i].order_status));
      }

      setState(() {
        orders = _temps;
        reloadListView();
        toMain = true;
      });
    });
  }

  void reloadListView() {
    orderedList = ListView(
      children: <Widget>[
        ...orders
            .map((order) => ExpansionTile(
                title: OrderHeaderList(order: order),
                children: [OrderItemList(items: order.items)]))
            .toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        // iconTheme: IconThemeData(
        //   color: Colors.black,
        // ),
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Orders',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (toMain) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MainPage()));
              } else {
                Navigator.of(context).pop(null);
              }
            },
          )
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: orderedList,
        ),
      ),
    );
  }
}

class Panel {
  String title;
  String content;
  bool expanded;

  Panel(this.title, this.content, this.expanded);
}

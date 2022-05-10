import 'dart:async';

import 'package:getko/src/ui/address/address_form.dart';
import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/address/add_address_page.dart';
// import 'package:getko/src/ui/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'components/credit_card.dart';
import 'components/shop_item_list.dart';
import 'package:getko/src/models/cart_model.dart';
import 'package:getko/src/models/credit_card_model.dart';
import 'package:getko/src/blocs/cart_bloc.dart';
import 'package:getko/src/blocs/user_bloc.dart';
import 'package:getko/src/models/home_recommend_product_model.dart';
import 'package:getko/src/models/paycard.dart';
import 'package:getko/src/ui/payment/payment_page.dart';

//TODO: NOT DONE. WHEEL SCROLL QUANTITY
class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

late StreamSubscription _cartListSubscription;
late StreamSubscription _cartDeleteSubscription;
late StreamSubscription _cartUpdateSubscription;
late StreamSubscription _cardListSubscription;
late StreamSubscription _cardAddSubscription;

class _CheckOutPageState extends State<CheckOutPage> {
  SwiperController swiperController = SwiperController();

  List<Product> products = [
    // Product('assets/headphones.png',
    //     'Boat roackerz 400 On-Ear Bluetooth Headphones', 'description', 45.3),
    // Product('assets/headphones_2.png',
    //     'Boat roackerz 100 On-Ear Bluetooth Headphones', 'description', 22.3),
    // Product('assets/headphones_3.png',
    //     'Boat roackerz 300 On-Ear Bluetooth Headphones', 'description', 58.3)
  ];
  List<PayCard> paycards = [
    PayCard('', '111-111-111-xxxx', 'LEE JIHOON1', '2022', '11'),
    PayCard('', '111-111-222-xxxx', 'LEE JIHOON2', '2023', '11'),
    PayCard('', '111-111-333-xxxx', 'LEE JIHOON3', '2024', '11'),
    PayCard('', '111-111-444-xxxx', 'LEE JIHOON4', '2025', '11'),
  ];
  PayCard selectedCard =
      PayCard('', '111-111-111-xxxx', 'LEE JIHOON1', '2022', '11');
  Widget cartItemListViewWidget = Container();
  Widget cardListViewWidget = Container();
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    cart_bloc.list();

    _cartListSubscription = cart_bloc.cartListFetcher.stream.listen((event) {
      print('cart_bloc list subscription => $event');
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
        products = _temps;
        reloadCartItemListView();
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
        products = _temps;
        reloadCartItemListView();
      });
    });

    _cartUpdateSubscription =
        cart_bloc.cartDeleteFetcher.stream.listen((event) {
      print('cart_bloc update subscription => $event, ${event.results}');
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
        products = _temps;
        reloadCartItemListView();
      });
    });

    user_bloc.listCreditCard();

    _cardListSubscription = user_bloc.cardListFetcher.stream.listen((event) {
      print('credit card subscription => $event');

      List<PayCard> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        _temps.add(PayCard(
            event.results[i].id.toString(),
            event.results[i].number,
            event.results[i].name,
            event.results[i].year,
            event.results[i].month));
      }

      setState(() {
        paycards = _temps;
        if (_temps.length > 0) selectedCard = _temps[0];
        reloadCardListView();
      });
    });

    _cardAddSubscription = user_bloc.cardAddFetcher.stream.listen((event) {
      print('credit card add => $event');

      List<PayCard> _temps = [];
      for (int i = 0; i < event.results.length; i++) {
        _temps.add(PayCard(
            event.results[i].id.toString(),
            event.results[i].number,
            event.results[i].name,
            event.results[i].year,
            event.results[i].month));
      }

      setState(() {
        paycards = _temps;
        selectedCard = _temps[_temps.length - 1];
        reloadCardListView();
      });
    });
  }

  void reloadCartItemListView() {
    cartItemListViewWidget = ListView.builder(
      itemBuilder: (_, index) => ShopItemList(
        products[index],
        onRemove: () {
          deleteCartItem(int.parse(products[index].id!));
        },
        onUpdate: updateCartItemQuantity,
      ),
      itemCount: products.length,
    );
  }

  void deleteCartItem(int _id) {
    cart_bloc.delete(_id);
  }

  void updateCartItemQuantity(int _id, int quantity) {
    cart_bloc.update(_id, quantity);
  }

  void addCard(
      String number, String year, String month, String cvc, String name) {
    user_bloc.addCreditCard(number, month, year, cvc, name);
  }

  void reloadCardListView() {
    cardListViewWidget = Swiper(
      onIndexChanged: (index) {
        setState(() {
          selectedCard = paycards[index];
        });
      },
      itemCount: paycards.length + 1,
      itemBuilder: (_, index) {
        if (index == paycards.length) {
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => PaymentPage(
                      addCard: addCard,
                    ))),
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width / 1.5,
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
              child: Center(
                child: Text("Add Card",
                    style: const TextStyle(
                        color: const Color(0xfffefefe),
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0)),
              ),
            ),
          );
        } else {
          return CreditCardWidget(card: paycards[index]);
        }
      },
      scale: 0.8,
      controller: swiperController,
      viewportFraction: 0.6,
      loop: false,
      fade: 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    Widget checkOutButton = InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AddAddressPage(
                selectedCard: selectedCard,
              ))),

      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
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
        child: Center(
          child: Text("Check Out",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('assets/icons/denied_wallet.png'),
            onPressed: () => {},
          )
        ],
        title: Text(
          'Checkout',
          style: TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  height: 48.0,
                  color: yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Subtotal',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        products.length.toString() + ' items',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Scrollbar(child: cartItemListViewWidget),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Payment',
                    style: TextStyle(
                        fontSize: 20,
                        color: darkGrey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 200, child: cardListViewWidget),
                SizedBox(height: 24),
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom == 0
                          ? 20
                          : MediaQuery.of(context).padding.bottom),
                  child: checkOutButton,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

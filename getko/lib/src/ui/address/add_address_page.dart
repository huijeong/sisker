import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:getko/src/ui/address/InputAddress.dart';
import 'package:getko/src/blocs/order_bloc.dart';
import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/ui/address/address_form.dart';
import 'package:flutter/material.dart';
import 'package:getko/src/blocs/user_bloc.dart';
import 'package:getko/src/models/paycard.dart';
import 'package:getko/src/ui/orders/order_page.dart';

class AddAddressPage extends StatefulWidget {
  final PayCard selectedCard;

  AddAddressPage({Key? key, required this.selectedCard}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState(this.selectedCard);
}

late StreamSubscription _addressListSubscription;
late StreamSubscription _addressDeleteSubscription;

class PayAddress {
  String id;
  String cardName;
  String address1;
  String address2;
  String postalCode;
  String phone;
  String email;

  PayAddress(this.id, this.cardName, this.address1, this.address2,
      this.postalCode, this.phone, this.email);
}

class _AddAddressPageState extends State<AddAddressPage> {
  List<PayAddress> addresses = [];
  Widget addressForm = Container();
  final PayCard selectedCard;
  _AddAddressPageState(this.selectedCard);
  PayAddress selectedAddress = PayAddress("", "", "", "", "", "", "");

  @override
  void initState() {
    super.initState();

    user_bloc.listAddress();
    _addressListSubscription =
        user_bloc.addressListFetcher.stream.listen((event) {
          print('user_bloc address list $event');
          List<PayAddress> _temps = [];
          for (int i = 0; i < event.results.length; i++) {
            _temps.add(PayAddress(
                event.results[i].id,
                event.results[i].full_name,
                event.results[i].address_line,
                event.results[i].address_line2,
                event.results[i].postcode,
                event.results[i].phone,
                event.results[i].email));
          }

          setState(() {
            addresses = _temps;
            reloadAddressForm(addresses[0]);
          });
        });

    _addressDeleteSubscription =
        user_bloc.addressDeleteFetcher.stream.listen((event) {
          List<PayAddress> _temps = [];
          for (int i = 0; i < event.results.length; i++) {
            _temps.add(PayAddress(
                event.results[i].id,
                event.results[i].full_name,
                event.results[i].address_line,
                event.results[i].address_line2,
                event.results[i].postcode,
                event.results[i].phone,
                event.results[i].email));
          }

          setState(() {
            addresses = _temps;
            reloadAddressForm(addresses[0]);
          });
        });
  }

  void reloadAddressForm(PayAddress address) {
    setState(() {
      selectedAddress = address;
      addressForm = AddAddressForm(address: address, addAddress: addAddress);
    });
  }

  void addAddress(PayAddress address) {
    selectedAddress = address;
  }

  void deleteAddress(PayAddress address) {
    print('delete Address $address');
    user_bloc.deleteAddress(address.id);
  }

  @override
  Widget build(BuildContext context) {
    Widget finishButton = InkWell(
      onTap: () async {
        print('payment card => ${selectedCard}');
        await initPaymentSheet(context, email: "hznnx5626@gmail.com", amount: 6000);
      },
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
          child: Text("Finish",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Add Address',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).padding.bottom == 0
                    ? 20
                    : MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: addresses.length + 1,
                      itemBuilder: (_, index) {
                        return index == addresses.length
                            ? InkWell(
                            onTap: () {
                             reloadAddressForm(PayAddress("", "", "", "", "", "", ""));
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 5.0),
                                color: yellow,
                                //elevation: 3,
                                child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(4.0),
                                            child: Image.asset(
                                                'assets/icons/address_home.png'),
                                          ),
                                          Text(
                                            'New Address',
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: darkGrey,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ))))
                            : Stack(children: <Widget>[
                          InkWell(
                              onTap: () {
                                reloadAddressForm(addresses[index]);
                              },
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 5.0),
                                  color: Colors.white,
                                  //elevation: 3,
                                  child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  4.0),
                                              child: Image.asset(
                                                  'assets/icons/address_home.png'),
                                            ),
                                            Text(
                                              addresses[index].cardName,
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: darkGrey,
                                              ),
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      )))),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Align(
                                  child: IconButton(
                                    icon: Image.asset('assets/red_clear.png'),
                                    iconSize: 14,
                                    onPressed: () {
                                      deleteAddress(addresses[index]);
                                    },
                                  ),
                                ),
                              )
                        ]);
                      },
                    )),
                SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,

                      // shrinkWrap: true,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                FloatingActionButton(
                    // margin: EdgeInsets.symmetric(
                    //     vertical: 8.0, horizontal: 5.0),
                    // color: Colors.white,
                    //elevation: 3,
                    onPressed: () {
                      print('button clicked');
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InputAddress()
                          )
                      );
                      },
                    child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.yellow,
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(0.1),
                                child: Text(
                                'Save Address',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                                )
                              ),
                            ],
                          ),
                        ))
                ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            color: yellow,
                            //elevation: 3,
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.asset(
                                          'assets/icons/address_home.png',
                                          color: Colors.white,
                                          height: 20,
                                        ),
                                      ),
                                      Text(
                                        'Simon Philip,\nCity Oscarlad',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ))),
                      ],
                    )),
                addressForm,
                Center(child: finishButton)
              ],
            ),
          ),
          // ),
        ),
      ),
    );
  }
}

Future<void> initPaymentSheet(context, {required String email, required int amount}) async {
  try {
    final response = await http.post(
        Uri.parse(
            'https://us-central1-sisker.cloudfunctions.net/stripePaymentIntentRequest'),
        body: {
          'email': email,
          'amount': amount.toString(),
        });

    final jsonResponse = jsonDecode(response.body);
    log(jsonResponse.toString());

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: jsonResponse['paymentIntent'],
        merchantDisplayName: 'Sisker 테스트 결제 앱',
        customerId: jsonResponse['customer'],
        customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        style: ThemeMode.light,
        testEnv: true,
        merchantCountryCode: 'SG',
      ),
    );

    await Stripe.instance.presentPaymentSheet();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('결제가 완료되었습니다!')),
    );
  } catch (e) {
    if (e is StripeException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error from Stripe: ${e.error.localizedMessage}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
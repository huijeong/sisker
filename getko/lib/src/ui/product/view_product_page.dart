import 'dart:async';

import 'package:getko/src/models/product.dart';
import 'package:getko/src/ui/product/components/rating_bottomSheet.dart';
// import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:getko/src/ui/app_properties.dart';
import 'components/color_list.dart';
import 'components/more_products.dart';
import 'components/product_options.dart';
import 'package:getko/src/models/product_option_model.dart';
import 'package:getko/src/blocs/product_bloc.dart';

class ViewProductPage extends StatefulWidget {
  final Product product;

  ViewProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ViewProductPageState createState() => _ViewProductPageState(product);
}

late StreamSubscription _optionStreamSub;

class DropDownItem {
  String _name = "";
  int _price = 0;
  List<DropDownItem> _sub = [];
  DropDownItem(this._name, this._price, this._sub);

  @override
  String toString() {
    return '$_name $_price $_sub';
  }

  String get name => _name;
  int get price => _price;
  List<DropDownItem> get sub => _sub;

  bool operator ==(dynamic other) =>
      other != null && other is DropDownItem && (_name) == (other._name);

  @override
  int get hashCode => super.hashCode;
}

class _ViewProductPageState extends State<ViewProductPage> {
  final Product product;
  List<DropDownItem> firstOption = [];
  List<DropDownItem> secondOption = [];
  List<DropDownItem> thirdOption = [];
  List<DropDownItem> forthOption = [];
  DropDownItem selectedFirstOption = DropDownItem('', 0, []);
  DropDownItem selectedSecondOption = DropDownItem('', 0, []);
  DropDownItem selectedThirdOption = DropDownItem('', 0, []);
  DropDownItem selectedForthOption = DropDownItem('', 0, []);
  // bool secondOptionVisibility = false;
  // bool thirdOptionVisibility = false;
  // bool forthOptionVisibility = false;
  ProductOptionModel options = ProductOptionModel();

  _ViewProductPageState(this.product);
  Widget productOptionWidget = Container();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late int active;

  @override
  void initState() {
    super.initState();
    print('product no => ${product.id}');
    product_bloc.option(product.id!);
    // product_bloc.option('11st_3244344641');
    _optionStreamSub = product_bloc.productOptionFetcher.stream.listen((event) {
      print('product_bloc options => $event');

      List<DropDownItem> _tempOne = [];
      List<DropDownItem> _tempSecond = [];
      if (event.options != null && event.options.length > 0) {
        for (int i = 0; i < event.options.length; i++) {
          List<DropDownItem> _tempThrid = [];
          for (int j = 0;
              event.options[i].sub != null && j < event.options[i].sub.length;
              j++) {
            List<DropDownItem> _tempForth = [];
            for (int k = 0;
                event.options[i].sub[j].sub != null &&
                    k < event.options[i].sub[j].sub.length;
                k++) {
              _tempForth.add(DropDownItem(event.options[i].sub[j].sub[k].txt,
                  event.options[i].sub[j].sub[k].addPrc, []));
            }
            _tempThrid.add(DropDownItem(event.options[i].sub[j].txt,
                event.options[i].sub[j].addPrc, _tempForth));
          }
          _tempSecond.add(DropDownItem(
              event.options[i].txt, event.options[i].addPrc, _tempThrid));
        }
      }
      _tempOne.add(DropDownItem(event.prd_nm, event.price_low, _tempSecond));
      setState(() {
        options = event;
        firstOption = _tempOne;
        selectedFirstOption = firstOption[0];
        List<DropDownItem> _temp2 = [];
        _temp2.add(DropDownItem("Please Select Option", 0, []));
        _temp2 = _temp2 + _tempOne[0].sub;
        if (_tempOne[0].sub != null && _tempOne[0].sub.length > 0) {
          selectedSecondOption = _tempOne[0].sub[0];
          secondOption = _tempOne[0].sub;
        }
        updateProductionWidget();
        // print('initState => ${secondOption} / ${secondOption.length}');
      });
    });
  }

  void updateProductionWidget() {
    // setState(() {
    productOptionWidget = ProductOption(_scaffoldKey,
        product: product,
        options: options,
        selectedFirstOption: selectedFirstOption,
        selectedSecondOption: selectedSecondOption,
        selectedThirdOption: selectedThirdOption,
        selectedForthOption: selectedForthOption);
    // });
  }

  ///list of product colors
  List<Widget> colors() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.primaries[i],
                child: SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Widget description = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        product.description,
        maxLines: 5,
        semanticsLabel: '...',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: yellow,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: new SvgPicture.asset(
                'assets/icons/search_icon.svg',
                fit: BoxFit.scaleDown,
              ),
              onPressed: () => {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage()))
              },
            )
          ],
          title: Text(
            'Product Detail',
            style: const TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                productOptionWidget,
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(253, 192, 84, 1),
                          borderRadius: BorderRadius.circular(4.0),
                          border:
                              Border.all(color: Color(0xFFFFFFFF), width: 0.5),
                        ),
                        child: Center(
                          child: new Text("Options",
                              style: const TextStyle(
                                  color: const Color(0xeefefefe),
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      items: firstOption.map((val) {
                        return DropdownMenuItem<DropDownItem>(
                          value: val,
                          child: Container(
                              // color: Colors.white,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.lightBlue.shade900))),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    val.name + " " + val.price.toString(),
                                    maxLines: 2,
                                    semanticsLabel: '...',
                                    overflow: TextOverflow.ellipsis,
                                  ))),
                        );
                      }).toList(),
                      onChanged: (val) {
                        DropDownItem newVal = val as DropDownItem;
                        List<DropDownItem> _temp = [];
                        for (int i = 0; i < firstOption.length; i++) {
                          if (newVal.name == firstOption[i].name) {
                            _temp = firstOption[i].sub;
                          }
                        }
                        setState(() {
                          selectedFirstOption = val as DropDownItem;
                          secondOption = _temp;
                          print('in first => second => $secondOption');
                          updateProductionWidget();
                        });
                      },
                      value: selectedFirstOption,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down),
                      // elevation: 0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                secondOption.length > 0
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: secondOption.map((val) {
                              // print('secondOption map => ${val.name}');
                              return DropdownMenuItem<DropDownItem>(
                                value: val,
                                child: Container(
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors
                                                    .lightBlue.shade900))),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          val.name + " " + val.price.toString(),
                                          maxLines: 2,
                                          semanticsLabel: '...',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                              );
                            }).toList(),
                            onChanged: (val) {
                              DropDownItem newVal = val as DropDownItem;
                              List<DropDownItem> _temp = [];
                              for (int i = 0; i < secondOption.length; i++) {
                                if (newVal.name == secondOption[i].name) {
                                  _temp = secondOption[i].sub;
                                }
                              }
                              setState(() {
                                selectedSecondOption = newVal;
                                if (_temp.length > 0) {
                                  thirdOption = _temp;
                                  selectedThirdOption = _temp[0];
                                }
                                updateProductionWidget();
                              });
                            },
                            value: selectedSecondOption,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            // elevation: 0,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 16.0,
                ),
                thirdOption.length > 0
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            items: thirdOption.map((val) {
                              return DropdownMenuItem<DropDownItem>(
                                value: val,
                                child: Container(
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors
                                                    .lightBlue.shade900))),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          val.name + " " + val.price.toString(),
                                          maxLines: 2,
                                          semanticsLabel: '...',
                                          overflow: TextOverflow.ellipsis,
                                        ))),
                              );
                            }).toList(),
                            onChanged: (val) {
                              DropDownItem newVal = val as DropDownItem;
                              List<DropDownItem> _temp = [];
                              for (int i = 0; i < thirdOption.length; i++) {
                                if (newVal.name == thirdOption[i].name) {
                                  _temp = thirdOption[i].sub;
                                }
                              }

                              setState(() {
                                if (_temp.length > 0) {
                                  forthOption = _temp;
                                  selectedForthOption = _temp[0];
                                }
                                // selectedThirdOption = val.toString();
                                selectedThirdOption = newVal;

                                updateProductionWidget();
                              });
                            },
                            value: selectedThirdOption,
                            isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_down),
                            // elevation: 0,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 16.0,
                ),
                forthOption.length > 0
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              items: forthOption.map((val) {
                                return DropdownMenuItem<DropDownItem>(
                                  value: val,
                                  child: Container(
                                      // color: Colors.white,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors
                                                      .lightBlue.shade900))),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            val.name +
                                                " " +
                                                val.price.toString(),
                                            maxLines: 2,
                                            semanticsLabel: '...',
                                            overflow: TextOverflow.ellipsis,
                                          ))),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedForthOption = val as DropDownItem;
                                  // print(
                                  //     'forthOption selected => $selectedForthOption');
                                  updateProductionWidget();
                                });
                              },
                              value: selectedForthOption,
                              isExpanded: true,
                              icon: Icon(Icons.keyboard_arrow_down),
                              elevation: 1,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 16.0,
                ),
                // Container(
                //     margin: const EdgeInsets.symmetric(horizontal: 16.0),
                //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: <Widget>[
                //         InkWell(
                //             onTap: () async {},
                //             child: Container(
                //                 width: MediaQuery.of(context).size.width / 2.5,
                //                 decoration: BoxDecoration(
                //                     color: Colors.red,
                //                     gradient: mainButton,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(5))),
                //                 padding: EdgeInsets.symmetric(vertical: 16.0),
                //                 child: Center(
                //                     child: Text('Buy Now',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold))))),
                //         InkWell(
                //             onTap: () async {

                //             },
                //             child: Container(
                //                 width: MediaQuery.of(context).size.width / 2.5,
                //                 decoration: BoxDecoration(
                //                     color: Colors.red,
                //                     gradient: mainButton,
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(5))),
                //                 padding: EdgeInsets.symmetric(vertical: 16.0),
                //                 child: Center(
                //                     child: Text('Add to Cart',
                //                         style: TextStyle(
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.bold)))))
                //       ],
                //     ))
              ],
            ),
          ),
        ));
  }
}

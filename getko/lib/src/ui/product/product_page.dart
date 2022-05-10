import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/models/product.dart';
// import 'package:getko/src/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/product_display.dart';
import 'view_product_page.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<ProductPage> {
  final Product product;

  _ProductPageState(this.product);

  Widget detail() {
    String product_no = product.url != null ? product.url!.split('/').last : '';
    print('detail => $product_no and product_url => ${product.url}');
    String product_url = '';
    if (product.url!.contains('naver')) {
      product_url = product.url!;
    } else if (product.url!.contains('11st')) {
      product_url = 'https://m.11st.co.kr/products/m/${product_no}';
    }
    return WebView(
      // initialUrl: 'https://m.11st.co.kr/products/m/${product_no}',
      initialUrl: product_url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget viewProductButton = InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ViewProductPage(
                product: product,
              ))),
      child: Container(
        height: 80,
        width: width / 1.5,
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
          child: Text("View Option",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
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
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage()))
            },
          )
        ],
        title: Text(
          'Product',
          style: const TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                ProductDisplay(
                  product: product,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 16.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                        color: const Color(0xFFFEFEFE),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 24.0,
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
                          child: new Text("Details",
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
                    height: 1000,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 130),
                        child: detail())),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(
                  top: 8.0, bottom: bottomPadding != 20 ? 20 : bottomPadding),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                    Color.fromRGBO(255, 255, 255, 0),
                    Color.fromRGBO(253, 192, 84, 0.5),
                    Color.fromRGBO(253, 192, 84, 1),
                  ],
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter)),
              width: width,
              height: 120,
              child: Center(child: viewProductButton),
            ),
          ),
        ],
      ),
    );
  }
}

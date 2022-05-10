import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF9F9F9),
        body: SafeArea(
            top: true,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: kToolbarHeight),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          maxRadius: 40,
                          backgroundImage: AssetImage('assets/background.jpg'),
                        )
                      ],
                    )))));
  }
}

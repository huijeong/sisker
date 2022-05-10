import 'package:flutter/material.dart';
import 'ui/splash_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sisker eCommerce',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          brightness: Brightness.light,
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat',
        ),
        home: SplashScreen());
  }
}

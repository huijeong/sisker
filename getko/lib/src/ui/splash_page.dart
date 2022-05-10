import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getko/src/ui/app_properties.dart';
import 'package:getko/src/ui/intro_page.dart';
import 'package:getko/src/ui/main/main_page.dart';
import 'package:getko/src/blocs/auth_bloc.dart';
import 'package:getko/src/models/login_model.dart';
import 'package:getko/src/util/shared_preferences.dart';
import 'package:getko/src/util/constants.dart';
import 'package:getko/src/util/util.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacity;
  late AnimationController controller;

  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    auth_bloc.login();

    _subscription = auth_bloc.authFetcher.stream.listen((event) {
      shared_pref.load(TOKEN).then((value) {
        // if (util.isEmpty(value)) {
        shared_pref.save(TOKEN, event.key);
        // } else {}
        controller.forward().then((_) {
          navigationPage();
        });
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void navigationPage() {
    print('navigatorPage called');
    shared_pref.load(SKIP_INTRO).then((value) {
      if (util.isEmpty(value)) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => IntroPage()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
      }
    });
    // Navigator.of(context)
    //     .pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
            decoration: BoxDecoration(color: transparentYellow),
            child: SafeArea(
              child: Scaffold(
                  body: Column(
                children: <Widget>[
                  Expanded(
                    child: Opacity(
                        opacity: opacity.value,
                        child: Image.asset('assets/logo.png')),
                  ),
                  // StreamBuilder(
                  //     stream: auth_bloc.authFetcher.stream,
                  //     builder: (context, AsyncSnapshot<LoginModel> snapshot) {
                  //       // print(snapshot.data);
                  //       // print(snapshot.data?.user);
                  //       // print(snapshot.data?.user.username);

                  //       return RichText(
                  //         text: TextSpan(
                  //             style: const TextStyle(color: Colors.blue),
                  //             children: [
                  //               TextSpan(text: snapshot.data?.user.username),
                  //             ]),
                  //       );
                  //     }),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              const TextSpan(text: 'Powered by '),
                              const TextSpan(
                                  text: 'sisker',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                      ))
                ],
              )),
            )));
  }
}

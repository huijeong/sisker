import 'package:flutter/material.dart';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey=
  "pk_test_51KHKHGLe6LRdoeyKRaLlyFmcfNyGQ2dHD7oqm7JBCvQgc7CjTASg4qU8wpfr4dvnY2pYcrjtl2kJoRMksqxGkAMd00543v8QbR";
  await Stripe.instance.applySettings();
  runApp(App());
}



import 'package:flutter/material.dart';
import 'package:pavium/config/debug.dart';
import 'package:pavium/env.dart';
import 'package:pavium/screen/home.dart';
import 'package:pavium/util/prefs.dart';

void main() async {
  await Prefs.init();

  Debug();
}

class MyApp extends StatelessWidget {
  final Env env;
  MyApp(this.env);

  @override
  Widget build(BuildContext context) {
    print('environment: ${env.name}');
    print('endpoint: ${env.endpoint}');

    return MaterialApp(
      title: 'Pavium',
      theme: _themeData(),
      home: HomePage(env),
    );
  }

  _themeData() {
    return ThemeData(
      primarySwatch: Colors.teal,
    );
  }
}

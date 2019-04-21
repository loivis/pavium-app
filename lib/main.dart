import 'package:flutter/material.dart';
import 'package:pavium/config/debug.dart';
import 'package:pavium/env.dart';
import 'package:pavium/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

void main() async {
  prefs = await SharedPreferences.getInstance();
  print("prefs loaded");
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
      home: HomePage(env, prefs),
    );
  }

  _themeData() {
    return ThemeData(
      primarySwatch: Colors.teal,
    );
  }
}

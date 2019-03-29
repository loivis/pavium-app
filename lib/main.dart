import 'package:flutter/material.dart';
import 'package:prunusavium/config/debug.dart';
import 'package:prunusavium/env.dart';
import 'package:prunusavium/screen/home.dart';

void main() => Debug();

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

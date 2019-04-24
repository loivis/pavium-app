import 'package:flutter/material.dart';
import 'package:pavium/config.dart';
import 'package:pavium/screen/home.dart';
import 'package:pavium/util/prefs.dart';

void main() async {
  await Prefs.init();

  Config("", "");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pavium',
      theme: _themeData(),
      home: HomePage(),
    );
  }

  _themeData() {
    return ThemeData(
      primarySwatch: Colors.teal,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:prunusavium/screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pavium',
      theme: _themeData(),
      home: Home(),
    );
  }

  _themeData() {
    return ThemeData(
      primarySwatch: Colors.teal,
    );
  }
}

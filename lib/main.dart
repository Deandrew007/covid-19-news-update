import 'package:flutter/material.dart';
import 'package:covid19newsapp/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Covid-19 NewsApp',
      home: new HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:neural_styler/choosepage.dart';
import 'package:neural_styler/homepage.dart';
import 'package:neural_styler/listpage.dart';
import 'package:neural_styler/vangogh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,

      ),
      home: ListPage(),
    );
  }
}
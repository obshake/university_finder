import 'package:flutter/material.dart';
import 'package:university_finder/result.dart';
import 'package:university_finder/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home',
    routes: {
      'home': (context) => MyHome(),
      'result': (context) => MyResult(),
    },
  ));
}
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens/screens.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cat vs dog detection',
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
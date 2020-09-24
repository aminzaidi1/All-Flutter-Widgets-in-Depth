import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:cats_vs_dogs/lib.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: MyHomeScreen(),
      title: Text(
        'Image Classification',
        style: TextStyle(fontWeight: bold,
            fontSize: 30,
            color: splashTextColor),
      ),
      image: Image.asset('assets/cat.png'),
      backgroundColor: backgroundColor,
      photoSize: 50,
      loaderColor: splashLoaderColor,
    );
  }
}

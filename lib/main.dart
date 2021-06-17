import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Text Loop Tool',
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          duration: 500,
          splash: Text(
            "DachWare",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          nextScreen: MyHomePage(),
          backgroundColor: Colors.black,
        ));
  }
}

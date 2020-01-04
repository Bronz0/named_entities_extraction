import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'home_screen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      home: SplashScreen(
        seconds: 4,
        navigateAfterSeconds: MyApp(),
        title: Text(
          'Named Entities Extraction',
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        loaderColor: Colors.red,
        loadingText: Text("v0.0.1"),
      ),
    );
  }
}

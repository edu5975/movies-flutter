import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard.dart';
import 'package:practica2/src/screens/detailScreen.dart';
import 'package:practica2/src/screens/popularScreen.dart';
import 'package:practica2/src/screens/profileScreen.dart';
import 'package:practica2/src/screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/dashboard': (BuildContext context) => Dashboard(),
        '/popular': (BuildContext context) => PopularScreen(),
        '/detail': (BuildContext context) => DetailScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
      },
      home: SplashScreenUser(),
    );
  }
}

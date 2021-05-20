import 'package:flutter/material.dart';
import 'package:practica2/src/screens/contactScreen.dart';
import 'package:practica2/src/screens/dashboard.dart';
import 'package:practica2/src/screens/detailScreen.dart';
import 'package:practica2/src/screens/favoriteScreen.dart';
import 'package:practica2/src/screens/popularScreen.dart';
import 'package:practica2/src/screens/profileScreen.dart';
// ignore: unused_import
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
        '/favorite': (BuildContext context) => FavoriteScreen(),
        '/contact': (BuildContext context) => ContactScreen(),
      },
      //home: SplashScreenUser(),
      home: Dashboard(),
    );
  }
}

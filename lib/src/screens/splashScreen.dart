import 'package:flutter/material.dart';
import 'package:practica2/src/screens/loginScreen.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenUser extends StatefulWidget {
  SplashScreenUser({Key key}) : super(key: key);

  @override
  _SplashScreenUserState createState() => _SplashScreenUserState();
}

class _SplashScreenUserState extends State<SplashScreenUser> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Login(),
      title: Text('Bienvenidos'),
      image: Image.asset(
        "assets/popcorn.png",
        width: 250,
        height: 150,
      ),
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.blue, Colors.blueGrey],
      ),
      loaderColor: Colors.red,
      loadingText: Text("Comenzando aplicación..."),
    );
  }
}

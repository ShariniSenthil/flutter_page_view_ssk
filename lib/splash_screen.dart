import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_page_view_ssk/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initstate() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        ()=> Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => MainScreen()))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    'images/james_williams_sketch.jpg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Why follow when you can lead.',
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 25.0,
                      letterSpacing: 2.5,
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_page_view_ssk/appdata_quotes.dart';
import 'package:flutter_page_view_ssk/main_screen.dart';
import 'package:flutter_page_view_ssk/splash_screen.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({ super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
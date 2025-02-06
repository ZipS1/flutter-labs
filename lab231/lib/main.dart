import 'package:flutter/material.dart';
import 'package:lab23/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF000000),
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}

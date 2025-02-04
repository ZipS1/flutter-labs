import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
      alignment: Alignment.center,
      child: Text(
        "Hello Flutter",
        style: TextStyle(
            color: Color(0xFFFF0000),
            fontWeight: FontWeight.bold,
            fontSize: 48),
        textAlign: TextAlign.center,
      ),
    ));
  }
}

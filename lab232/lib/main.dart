import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF3F55C0)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: _button(),
      ),
    );
  }

  FloatingActionButton _button() => FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(
          Icons.cloud_download,
          color: Colors.white,
          size: 30,
        ),
      );

  Widget _body() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              color: Colors.blue,
              value: 100,
            ),
            Text(
              "23 %",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Press button to download",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text("My First App", style: TextStyle(color: Color(0xFFFFFFFF))),
      backgroundColor: Color(0xFF1690F8),
    );
  }
}

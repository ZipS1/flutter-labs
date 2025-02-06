import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF778ACE)),
      home: Scaffold(
        appBar: _appBar(),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap \"–\" to decrement",
              style: _defaultTextStyle(),
            ),
            CounterWidget(),
            Text(
              "Tap \"+\" to increment",
              style: _defaultTextStyle(),
            ),
          ],
        )),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Counter", style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.blue,
    );
  }

  TextStyle _defaultTextStyle() {
    return TextStyle(color: Colors.white);
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.1,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.blueGrey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            IconButton(
                onPressed: _decrementCallback,
                icon: Icon(
                  Icons.remove,
                  color: Colors.black,
                )),
            Text(
              "$counter",
              style: _counterTextStyle(),
            ),
            IconButton(
                onPressed: _incrementCallback,
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }

  void _decrementCallback() {
    setState(() {
      if (counter == 0) return;
      counter--;
    });
  }

  void _incrementCallback() {
    setState(() {
      counter++;
    });
  }

  TextStyle _counterTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 24);
  }
}

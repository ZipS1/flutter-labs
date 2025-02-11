import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const apiUrl = "https://www.themealdb.com/api/json/v1/1/random.php";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: DataReceiver(),
      ),
    );
  }
}

class DataReceiver extends StatefulWidget {
  const DataReceiver({super.key});

  @override
  State<DataReceiver> createState() => _DataReceiverState();
}

class _DataReceiverState extends State<DataReceiver> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          ElevatedButton(onPressed: _onClick, child: Text("Запросить данные")),
          Text(text)
        ],
      ),
    );
  }

  void _onClick() async {
    setState(() {
      text = "Loading...";
    });
    final response = await http.get(Uri.parse(apiUrl));
    setState(() {
      text = "Handling the response...";
    });
    setState(() {
      try {
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          text = data["meals"][0]["strInstructions"] ??
              "Cannot find strInstructions";
        } else {
          text = 'Error: ${response.statusCode}';
        }
      } catch (e) {
        text = 'Connection error: $e';
      }
    });
  }
}

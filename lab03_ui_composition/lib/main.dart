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
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.red,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      title: Text("Weather Forecast"),
    );
  }

  Widget _body() {
    double space = 30;
    return ListView(
      children: [
        _searchBar(),
        SizedBox(
          height: space,
        ),
        _cityDetails(),
        SizedBox(
          height: space,
        ),
        _temperatureDetails(),
        SizedBox(
          height: space,
        ),
        _extraWeatherDetails(),
        SizedBox(
          height: space,
        ),
        _bottomDetails()
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Enter City Name",
            hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            prefixIconColor: Colors.white),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _cityDetails() {
    return Column(
      spacing: 10,
      children: [
        Text(
          "Murmansk Oblast, RU",
          style: TextStyle(color: Colors.white, fontSize: 32),
        ),
        Text(
          "Friday, Mar 20, 2020",
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget _temperatureDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 20,
      children: [
        Icon(
          Icons.sunny,
          color: Colors.white,
          size: 60,
        ),
        Column(
          children: [
            Text(
              "14 F",
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            Text(
              "Light snow",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
          ],
        )
      ],
    );
  }

  Widget _extraWeatherDetails() {
    return Row(
      spacing: 80,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _weatherDetailIcon("5", "km/hr"),
        _weatherDetailIcon("3", "%"),
        _weatherDetailIcon("20", "%")
      ],
    );
  }

  Widget _weatherDetailIcon(String firstLine, String secondLine) {
    return Column(
      children: [
        Icon(
          Icons.sunny_snowing,
          color: Colors.white,
        ),
        Text(
          firstLine,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        Text(
          secondLine,
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
      ],
    );
  }

  Widget _bottomDetails() {
    return Column(
      children: [
        Text(
          "7-DAY WEATHER FORECAST",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              _bottomDetailWidget("Friday"),
              _bottomDetailWidget("Saturday"),
              _bottomDetailWidget("Sunday"),
            ],
          ),
        )
      ],
    );
  }

  Container _bottomDetailWidget(firstLine) {
    return Container(
      width: 200,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      color: Color.fromARGB(128, 225, 225, 225),
      child: Column(
        spacing: 10,
        children: [
          Text(firstLine, style: TextStyle(color: Colors.white, fontSize: 24)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Text("6 F", style: TextStyle(color: Colors.white, fontSize: 24)),
              Icon(
                Icons.sunny,
                size: 30,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}

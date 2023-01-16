import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  WeatherPageState createState() => WeatherPageState();
}

class WeatherPageState extends State<WeatherPage> {
  String temperature = "";
  String weatherCondition = "";
  String location = "istanbul";
  String searchLocation = "istanbul";

  @override
  void initState() {
    super.initState();
    updateWeather();
  }

  void updateWeather() async {
    var url =
        "http://api.openweathermap.org/data/2.5/weather?q=$searchLocation&appid=543063903e5b75f78827f3bff7ce5596";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var main = data["main"];
      var weather = data["weather"][0];
      var temperatureCelsius = (main["temp"] - 273.15).toStringAsFixed(1);
      setState(() {
        temperature = temperatureCelsius;
        weatherCondition = weather["main"];
        location = data["name"];
      });
    }
  }

  Widget weatherImage() {
    if (weatherCondition == "Clear") {
      return Image(
        image: AssetImage("assets/clear.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Clouds") {
      return Image(
        image: AssetImage("assets/cloudy.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Rain") {
      return Image(
        image: AssetImage("assets/rainy.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Drizzle") {
      return Image(
        image: AssetImage("assets/rainy.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Snow") {
      return Image(
        image: AssetImage("assets/snowy.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Sun") {
      return Image(
        image: AssetImage("assets/sunny.png"),
        width: 200,
        height: 200,
      );
    } else if (weatherCondition == "Mist") {
      return Image(
        image: AssetImage("assets/mist.png"),
        width: 200,
        height: 200,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Enter location:",
            style: TextStyle(fontSize: 30.0),
          ),
          Container(
            width: 200,
            child: TextField(
              onSubmitted: (value) {
                setState(() {
                  searchLocation = value;
                });
                updateWeather();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          weatherImage(),
          SizedBox(height: 32),
          Text(
            "${(temperature)}°C",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 16),
          Text(
            "$weatherCondition",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 16),
          Text(
            "$location",
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: updateWeather,
                child: Text("Refresh"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

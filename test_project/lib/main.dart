import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String _apiKey = 'YOUR_ACCUWEATHER_API_KEY';
  String _locationKey = 'YOUR_LOCATION_KEY';
  String _weather = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    var response = await http.get(Uri.parse(
        'http://dataservice.accuweather.com/currentconditions/v1/$_locationKey?apikey=$_apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _weather = data[0]['WeatherText'];
      });
    } else {
      print('Failed to fetch weather data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Current Weather:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                _weather,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

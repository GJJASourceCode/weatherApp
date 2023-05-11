import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final String _apiKey = 'mJRBQb1ACnfWYwaVo0dGNximVG6LVEo9';
  final String _locationKey = '3429990';
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
          title: const Text('Weather App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.cloud,
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Current Weather:',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                _weather,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

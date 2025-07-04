import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<List<WeatherModel>> fetchWeather();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  static const _apiKey = '1407c499f297db9aeea81c6ed861dc95';
  static const _city = 'Berlin';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  @override
  Future<List<WeatherModel>> fetchWeather() async {
    final url = Uri.parse('$_baseUrl?q=$_city&appid=$_apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<WeatherModel>.from(
          data['list'].map((e) => WeatherModel.fromJson(e)),
        );
      } else {
        throw Exception('Server responded with status: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

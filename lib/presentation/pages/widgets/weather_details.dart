import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/app_strings.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDetails({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${AppStrings.humidity}: ${weather.humidity}%',
            style: const TextStyle(fontSize: 16)),
        Text('${AppStrings.pressure}: ${weather.pressure} hPa',
            style: const TextStyle(fontSize: 16)),
        Text('${AppStrings.wind}: ${weather.wind} km/h',
            style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}

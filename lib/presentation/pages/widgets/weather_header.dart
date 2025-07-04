import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/theme/app_sizing.dart';
import 'package:weather_app/presentation/theme/app_spacing.dart';

class WeatherHeader extends StatelessWidget {
  final WeatherEntity weather;
  final bool isCelsius;

  const WeatherHeader(
      {super.key, required this.weather, required this.isCelsius});

  int _formatTemp(double temp) =>
      isCelsius ? temp.round() : ((temp * 9 / 5) + 32).round();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat('EEEE').format(weather.date),
            style: const TextStyle(fontSize: 24)),
        const SizedBox(height: AppSpacing.md),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png',
            height: AppSizing.imageSize),
        const SizedBox(height: AppSpacing.md),
        Text('${_formatTemp(weather.temperature)}°',
            style: const TextStyle(fontSize: 48)),
        Text(weather.condition, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}

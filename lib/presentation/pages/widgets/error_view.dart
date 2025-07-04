import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_strings.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

class ErrorView extends StatelessWidget {
  final String message;
  const ErrorView(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<WeatherBloc>().add(FetchWeatherEvent()),
            child: const Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}

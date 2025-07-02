import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/app_strings.dart';

import '../bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int selectedIndex = 0;
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: [
          Switch(
            value: isCelsius,
            onChanged: (v) => setState(() => isCelsius = v),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.forecast[selectedIndex];
            return RefreshIndicator(
              onRefresh: () async {
                context.read<WeatherBloc>().add(FetchWeatherEvent());
              },
              child: ListView(
                children: [
                  const SizedBox(height: 12),
                  Center(
                      child: Text(DateFormat('EEEE').format(weather.date),
                          style: const TextStyle(fontSize: 24))),
                  Center(
                      child: Image.network(
                          'https://openweathermap.org/img/w/${weather.icon}.png')),
                  Center(
                      child: Text('${_formatTemp(weather.temperature)}°',
                          style: const TextStyle(fontSize: 48))),
                  Center(
                      child: Text(weather.condition,
                          style: const TextStyle(fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppStrings.humidity}: ${weather.humidity}%',
                            style: const TextStyle(fontSize: 16)),
                        Text('${AppStrings.pressure}: ${weather.pressure} hPa',
                            style: const TextStyle(fontSize: 16)),
                        Text('${AppStrings.wind}: ${weather.wind} km/h',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.forecast.length,
                      itemBuilder: (context, index) {
                        final item = state.forecast[index];
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == index
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('E').format(item.date)),
                                Image.network(
                                    'https://openweathermap.org/img/w/${item.icon}.png',
                                    height: 30),
                                Text('${_formatTemp(item.temperature)}°'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (state is WeatherError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(AppStrings.errorLoading),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<WeatherBloc>().add(FetchWeatherEvent()),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  int _formatTemp(double temp) =>
      isCelsius ? temp.round() : ((temp * 9 / 5) + 32).round();
}

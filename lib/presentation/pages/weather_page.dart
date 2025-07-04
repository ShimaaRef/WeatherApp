import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/constants/app_strings.dart';
import 'package:weather_app/presentation/theme/app_colors.dart';
import 'package:weather_app/presentation/theme/app_sizing.dart';
import 'package:weather_app/presentation/theme/app_spacing.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: [
          Row(
            children: [
              const Text("°C/°F", style: TextStyle(fontSize: 14)),
              Switch(
                value: isCelsius,
                onChanged: (v) => setState(() => isCelsius = v),
              ),
              const SizedBox(width: AppSpacing.lg),
            ],
          ),
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
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  Center(
                    child: Text(
                      DateFormat('EEEE').format(weather.date),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: Image.network(
                      'https://openweathermap.org/img/w/${weather.icon}.png',
                      height: AppSizing.imageSize,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: Text(
                      '${_formatTemp(weather.temperature)}°',
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                  Center(
                    child: Text(
                      weather.condition,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppStrings.humidity}: ${weather.humidity}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${AppStrings.pressure}: ${weather.pressure} hPa',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${AppStrings.wind}: ${weather.wind} km/h',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    height: AppSizing.listItemHeight,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.forecast.length,
                      itemBuilder: (context, index) {
                        final item = state.forecast[index];
                        return GestureDetector(
                          onTap: () => setState(() => selectedIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                            ),
                            padding: const EdgeInsets.all(AppSpacing.md),
                            width: AppSizing.listItemWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == index
                                  ? AppColors.primary
                                  : AppColors.secondary.shade300,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('E').format(item.date)),
                                const SizedBox(height: AppSpacing.xs),
                                Image.network(
                                  'https://openweathermap.org/img/w/${item.icon}.png',
                                  height: AppSizing.iconSize,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text('${_formatTemp(item.temperature)}°'),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
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

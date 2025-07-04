import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_strings.dart';
import 'package:weather_app/presentation/pages/widgets/error_view.dart';
import 'package:weather_app/presentation/pages/widgets/forecast_list.dart';
import 'package:weather_app/presentation/pages/widgets/unit_toggle.dart';
import 'package:weather_app/presentation/pages/widgets/weather_details.dart';
import 'package:weather_app/presentation/pages/widgets/weather_header.dart';
import 'package:weather_app/presentation/theme/app_colors.dart';
import 'package:weather_app/presentation/theme/app_spacing.dart';

import '../../bloc/weather_bloc.dart';

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
          UnitToggle(
              isCelsius: isCelsius,
              onChanged: (v) => setState(() => isCelsius = v))
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading)
            return const Center(child: CircularProgressIndicator());
          if (state is WeatherError) return ErrorView(state.message);
          if (state is WeatherLoaded) {
            final weather = state.forecast[selectedIndex];
            return RefreshIndicator(
              onRefresh: () async {
                context.read<WeatherBloc>().add(FetchWeatherEvent());
              },
              child: OrientationBuilder(
                builder: (context, orientation) {
                  final isPortrait = orientation == Orientation.portrait;

                  return ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    children: [
                      const SizedBox(height: AppSpacing.lg),

                      // Adaptive section
                      if (isPortrait)
                        Column(
                          children: [
                            WeatherHeader(
                                weather: weather, isCelsius: isCelsius),
                            const SizedBox(height: AppSpacing.lg),
                            WeatherDetails(weather: weather),
                          ],
                        )
                      else
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: WeatherHeader(
                                  weather: weather, isCelsius: isCelsius),
                            ),
                            const SizedBox(width: AppSpacing.lg),
                            Expanded(
                              child: WeatherDetails(weather: weather),
                            ),
                          ],
                        ),

                      const SizedBox(height: AppSpacing.xl),
                      ForecastList(
                        forecast: state.forecast,
                        selectedIndex: selectedIndex,
                        isCelsius: isCelsius,
                        onTap: (i) => setState(() => selectedIndex = i),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

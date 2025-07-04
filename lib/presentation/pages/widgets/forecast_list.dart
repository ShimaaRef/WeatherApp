import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/presentation/theme/app_colors.dart';
import 'package:weather_app/presentation/theme/app_sizing.dart';
import 'package:weather_app/presentation/theme/app_spacing.dart';

class ForecastList extends StatelessWidget {
  final List<WeatherEntity> forecast;
  final int selectedIndex;
  final bool isCelsius;
  final ValueChanged<int> onTap;

  const ForecastList({
    super.key,
    required this.forecast,
    required this.selectedIndex,
    required this.isCelsius,
    required this.onTap,
  });

  int _formatTemp(double temp) =>
      isCelsius ? temp.round() : ((temp * 9 / 5) + 32).round();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizing.listItemHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecast.length,
          itemBuilder: (context, index) {
            final item = forecast[index];
            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
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
    );
  }
}

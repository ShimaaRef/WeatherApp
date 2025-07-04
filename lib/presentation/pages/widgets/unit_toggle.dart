import 'package:flutter/material.dart';
import 'package:weather_app/presentation/theme/app_spacing.dart';

class UnitToggle extends StatelessWidget {
  final bool isCelsius;
  final ValueChanged<bool> onChanged;

  const UnitToggle({required this.isCelsius, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("°C/°F", style: TextStyle(fontSize: 14)),
        Switch(value: isCelsius, onChanged: onChanged),
        const SizedBox(width: AppSpacing.lg),
      ],
    );
  }
}

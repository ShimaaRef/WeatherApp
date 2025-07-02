class WeatherEntity {
  final DateTime date;
  final String condition;
  final String icon;
  final double temperature;
  final double humidity;
  final double pressure;
  final double wind;

  WeatherEntity({
    required this.date,
    required this.condition,
    required this.icon,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.wind,
  });
}

class WeatherModel {
  final DateTime date;
  final String condition;
  final String icon;
  final double temperature;
  final double humidity;
  final double pressure;
  final double wind;

  WeatherModel({
    required this.date,
    required this.condition,
    required this.icon,
    required this.temperature,
    required this.humidity,
    required this.pressure,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      temperature: json['main']['temp'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      wind: json['wind']['speed'].toDouble(),
    );
  }
}

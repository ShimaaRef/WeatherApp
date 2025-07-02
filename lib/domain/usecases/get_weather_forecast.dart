import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeatherForecast {
  final WeatherRepository repository;
  GetWeatherForecast(this.repository);

  Future<List<WeatherEntity>> call() => repository.getWeatherForecast();
}

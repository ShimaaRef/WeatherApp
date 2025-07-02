import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<WeatherEntity>> getWeatherForecast() async {
    final models = await remoteDataSource.fetchWeather();
    return models
        .map((e) => WeatherEntity(
              date: e.date,
              condition: e.condition,
              icon: e.icon,
              temperature: e.temperature,
              humidity: e.humidity,
              pressure: e.pressure,
              wind: e.wind,
            ))
        .toList();
  }
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/domain/entities/weather_entity.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_weather_forecast.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

/// Fake repository that returns fixed forecast data
class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<List<WeatherEntity>> getWeatherForecast() async {
    return [
      WeatherEntity(
        date: DateTime(2025, 7, 4),
        condition: 'Clear',
        icon: '01d',
        temperature: 25.5,
        humidity: 40,
        pressure: 1013,
        wind: 5.0,
      ),
    ];
  }
}

/// Fake use case that uses the fake repository
class FakeGetWeatherForecast extends GetWeatherForecast {
  FakeGetWeatherForecast() : super(FakeWeatherRepository());
}

void main() {
  group('WeatherBloc', () {
    late WeatherBloc weatherBloc;

    setUp(() {
      weatherBloc = WeatherBloc(FakeGetWeatherForecast());
    });

    tearDown(() {
      weatherBloc.close();
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeatherEvent is added',
      build: () => weatherBloc,
      act: (bloc) => bloc.add(FetchWeatherEvent()),
      expect: () => [
        isA<WeatherLoading>(),
        isA<WeatherLoaded>(),
      ],
    );
  });
}

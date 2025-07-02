import 'package:get_it/get_it.dart';

import '../../data/data_sources/weather_remote_data_source.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/usecases/get_weather_forecast.dart';
import '../../presentation/bloc/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => WeatherBloc(sl()));
  sl.registerLazySingleton(() => GetWeatherForecast(sl()));
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(sl()));
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl());
}

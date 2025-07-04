import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/weather_entity.dart';
import '../../domain/usecases/get_weather_forecast.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {}

abstract class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final List<WeatherEntity> forecast;
  WeatherLoaded(this.forecast);

  @override
  List<Object?> get props => [forecast];
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherForecast getWeatherForecast;

  WeatherBloc(this.getWeatherForecast) : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_onFetch);
  }

  Future<void> _onFetch(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoading());
      final forecast = await getWeatherForecast();
      emit(WeatherLoaded(forecast));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}

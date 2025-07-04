# Weather App

A Flutter application that displays weather forecasts for a given city using the OpenWeatherMap API.

## Features

- Loading indicator while fetching data
- Weather forecast list with:
  - Day of week (abbreviation)
  - Weather icon
- Detail view with:
  - Full day name
  - Temperature (°C/°F toggle)
  - Humidity, Pressure, Wind speed
- Refresh with pull-to-refresh gesture
- Error screen with retry button
- Horizontal + vertical layout support
- Animation when changing selected forecast item
- Network connection error handling with meaningful UI message

## Architecture

This app uses Clean Architecture with the following layers:

- `data` → API models and remote data source
- `domain` → Business logic, entities, repositories, use case
- `presentation` → UI (Flutter + BLoC)
- `core` → Constants, dependency injection

## Design System

- `AppSpacing` → consistent spacing units (xs–xl)
- `AppSizing` → layout sizes, icon and item dimensions
- `AppColors` → theming and semantic colors

## Tech Stack

- Flutter
- Dart
- BLoC + Equatable
- GetIt (DI)
- REST API via `http`
- OpenWeatherMap (Free Plan)

## Tests

- Unit test for `WeatherBloc` in `test/weather_bloc_test.dart`
- Uses `bloc_test` for verifying state transitions

## How to Run

1. Replace `YOUR_API_KEY` in `weather_remote_data_source.dart` with your OpenWeatherMap API key.
2. Run:
   ```bash
   flutter pub get
   flutter run


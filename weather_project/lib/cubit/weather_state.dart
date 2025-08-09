abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String temperature;
  final String description;
  final String city;
  final List<String> savedCities;
  WeatherLoaded({
    required this.temperature,
    required this.description,
    required this.city,
    required this.savedCities,
  });
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
// weatherDelete extends WeatherState
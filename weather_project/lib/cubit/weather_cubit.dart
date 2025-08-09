import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'weather_state.dart';
import '../weather_service.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  List<String> savedCities = [];

  Future<void> loadSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    savedCities = prefs.getStringList('saved_cities') ?? [];
  }

  Future<void> saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cities = prefs.getStringList('saved_cities') ?? [];
    if (!cities.contains(city)) {
      cities.add(city);
      await prefs.setStringList('saved_cities', cities);
    }
    savedCities = cities;
    print("Saved cities: $cities");
  }

  Future<void> fetchWeather(String city) async {
    emit(WeatherLoading());

    try {
      await loadSavedCities();
      await saveCity(city);

      final weatherData = await WeatherService().fetchWeather(city);
      final temp = weatherData['main']['temp'];
      final desc = weatherData['weather'][0]['description'];

      emit(
        WeatherLoaded(
          temperature: temp.toString(),
          description: desc.toString(),
          city: city,
          savedCities: savedCities,
        ),
      );
    } catch (e) {
      emit(WeatherError('something went wrong'));
    }
  }

  void removeCity(String city) async {
    final weatherData = await WeatherService().fetchWeather(city);
    final temp = weatherData['main']['temp'];
    final desc = weatherData['weather'][0]['description'];
    final prefs = await SharedPreferences.getInstance();
    savedCities.remove(city);
    await prefs.setStringList('saved_cities', savedCities);
    // emit(
    //   WeatherLoaded(
    //     temperature: temp.toString(),
    //     description: desc.toString(),
    //     city: city,
    //     savedCities: savedCities,
    //   ),
    // );
    emit(WeatherInitial());
  }

  void clearSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('saved_cities');
    savedCities.clear();
    emit(WeatherInitial());
  }
}

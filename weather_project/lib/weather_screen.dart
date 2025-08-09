import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_project/cubit/weather_cubit.dart';
import 'package:weather_project/cubit/weather_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});

  final TextEditingController weatherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InkWell cardCity(String city) {
      return InkWell(
        onTap: () {
          context.read<WeatherCubit>().fetchWeather(city);
          print(city);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF189AB4),
          ),
          child: Text(city),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFFEAF6F6),
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh), //
            onPressed: () {
              context.read<WeatherCubit>().clearSavedCities();
            },
          ),
        ],
        backgroundColor: Color(0xFF54BAB9),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: weatherController,
              decoration: InputDecoration(
                hintText: 'Search city...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                cardCity("Madinah"),
                cardCity("Jeddah"),
                cardCity("Makkah"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final city = weatherController.text;

                context.read<WeatherCubit>().fetchWeather(city);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF189AB4),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Search',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 30),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is WeatherInitial) {
                  return Center(child: Text("Start to search any city"));
                } else if (state is WeatherLoaded) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            state.city,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF189AB4),
                            ),
                          ),
                          Text(
                            '${state.temperature}°C',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF05445E),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${state.description}',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 180, 199, 197),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  );
                } else {
                  return SizedBox.shrink(); //
                }
              },
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoaded && state.savedCities.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Saved Cities:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.savedCities.map((city) {
                          return InkWell(
                            onDoubleTap: () {
                              context.read<WeatherCubit>().removeCity(city);
                            },
                            onTap: () {
                              context.read<WeatherCubit>().fetchWeather(city);
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFF189AB4),
                              ),
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

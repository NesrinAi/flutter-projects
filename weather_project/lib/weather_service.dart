// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class WeatherService{
//   //i promise i will get u smth type <> inside the angle brakets yet not now
//   //now about map it is just a way of saying my keys are String but values? u will get whatever
//   // why map? json is like a dictionary and we use map dart to deal with it

//   Future<Map<String, dynamic>> fetchWeather(String city) async {
//     final url = Uri.parse("https://wttr.in/$city?format=j1");
//     final response = await http.get(url);
//     if (response.statusCode == 200){
//       return jsonDecode(response.body);

//     } else {
//       throw Exception("failed to load");
//     }

//     }

//   }
import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '87af2abc76e3ac06c31276f6904'; //not the real api key

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric',
    );
    final response = await http.get(url);
    // {"name":"bassam", "field": 23}

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('failed to load');
    }
  }
}

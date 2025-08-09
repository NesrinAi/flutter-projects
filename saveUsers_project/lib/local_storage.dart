import 'dart:convert';

import 'package:flutter_application_1/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // static Future<void> saveUsers(Users users) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   String s = jsonEncode(
  //     users.toJson(),
  //   ); //take the user convert it to map (tojson) than to String (jsonEncode)
  //   pruserint(s);
  //   await prefs.setString('saved_user', s);
  // }

  // static Future<Users?> getUser() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   //get the string if null retrun ''
  //   // String s = prefs.getString('saved_user') ?? ' ';
  //   String? s = prefs.getString('saved_user');
  //   if (s == null) return null;
  //   //convert it back to map
  //   Map<String, dynamic> map = jsonDecode(s);
  //   //we use from json now to get the user obj and return it 3
  //   print(map);
  //   return Users.fromJson(map);
  // }
  static Future<void> saveUser(Users user) async {
    // we need shared preferences now
    final prefs = await SharedPreferences.getInstance();
    //now we create a list of string
    List<String> userList = prefs.getStringList('users') ?? [];
    String userjson = jsonEncode(user.toJson());
    userList.add(userjson);
    await prefs.setStringList('users', userList);
  }

  static Future<List<Users>> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    // get the saved list of user strings
    List<String> userList = prefs.getStringList('users') ?? [];

    // turn every json string into a Users object meaning turn ur list to map

    // List<Users> a = [];
    // for (int i = 0; i < userList.length; i++) {
    //   a[i] = Users.fromJson(jsonDecode(userList[i]));
    // }

    List<Users> users = userList.map((u) {
      //  .map() is a method that works on lists.
      // It goes through each item in a list, does something to it, and then gives you back a new list with the results.
      print(u);
      Map<String, dynamic> userMap = jsonDecode(u); // convert string → map
      return Users.fromJson(userMap); // convert map → object
    }).toList();

    return users;
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('users');
  }

  static Future<void> saveUsers(List<Users> users) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> userStrings = users
        .map((i) => jsonEncode(i.toJson()))
        .toList();
    await prefs.setStringList('users', userStrings);
  }
}

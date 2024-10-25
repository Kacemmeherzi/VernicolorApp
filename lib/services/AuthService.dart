import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vernicolorapp/config/config.dart';
import 'package:vernicolorapp/models/LoginResponse.dart';
import 'package:vernicolorapp/models/User.dart';

class AuthService {

  final String baseUrl= Config.apiUrlDev ;


  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
       Map<String, dynamic> json = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(json);

      // Save user locally
      await saveUser(apiResponse.user);
     return  {'success': true, 'body':  jsonDecode(response.body)};
     
      

    } else {
      return {'success': false, 'error': response.body};
    }
  }
  Future<User?> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Get the JSON string from shared preferences
  String? userJson = prefs.getString('user');
  
  if (userJson == null) {
    return null; // No user saved
  }

  // Convert the JSON string back to a User object
  Map<String, dynamic> userMap = jsonDecode(userJson);
  return User.fromJson(userMap);
}
Future<void> saveUser(User user) async {
   final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Convert User object to JSON string
  String userJson = jsonEncode(user.toJson());
  
  // Save JSON string in shared preferences
  await prefs.setString('user', userJson);
  print('User saved locally');
}
Future<void> clearUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
  print('User data cleared');
}
}
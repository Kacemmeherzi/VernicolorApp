import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  final String baseUrl= "http://10.0.2.2:8082/auth" ;


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
     return  {'success': true, 'body':  jsonDecode(response.body)};
      

    } else {
      return {'success': false, 'error': response.body};
    }
  }
  Future<Map<String, String?>> getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String? username = prefs.getString('username');
  String? token = prefs.getString('token');
  
  return {
    'username': username,
    'token': token,
  };
}
Future<void> saveUser(String username, String token) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Save user information in shared preferences
  await prefs.setString('username', username);
  await prefs.setString('token', token);
}
}
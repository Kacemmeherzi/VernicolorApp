import 'package:http/http.dart' as http;
import 'dart:convert';

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
}
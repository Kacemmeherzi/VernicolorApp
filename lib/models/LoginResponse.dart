import 'package:vernicolorapp/models/User.dart';

class ApiResponse {
  final User user;
  final String message;

  ApiResponse({required this.user, required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      user: User.fromJson(json['user']),
      message: json['message'],
    );
  }
}
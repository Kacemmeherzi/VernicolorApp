
class User {
  final String username;
  final int id;
  final String role;

  User({required this.username, required this.id, required this.role});

 Map<String, dynamic> toJson() {
    return {
      'username': username,
      'id': id,
      'role': role,
    };
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      id: json['id'],
      role: json['role'],
    );
  }
}
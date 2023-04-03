class User {
  int? user_id;
  String username;
  String password;
  String role;
  String? email;
  String? phone;

  User({
    this.user_id,
    required this.username,
    required this.password,
    required this.role,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'username': username,
      'password': password,
      'role': role,
      'email': email ?? '', // Use null-aware operator to handle null values
      'phone': phone ?? '', // Use null-aware operator to handle null values
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'],
      username: map['username'],
      password: map['password'],
      role: map['role'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}

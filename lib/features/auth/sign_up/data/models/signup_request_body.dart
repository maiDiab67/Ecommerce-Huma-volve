class SignupRequestBody {
  final String name;
  final String email;
  final String password;
  final String avatar;
  final String role;

  SignupRequestBody({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'avatar': avatar,
      'role': role,
    };
  }
}

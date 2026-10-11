class SignupResponse {
  final int id;
  final String email;
  final String name;
  final String avatar;
  final String role;
  final String? createdAt;
  final String? updatedAt;

  SignupResponse({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

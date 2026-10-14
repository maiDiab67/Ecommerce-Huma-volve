import '../../domain/entities/signup_response_entity.dart';

class SignupResponse extends SignupResponseEntity {
  SignupResponse({
    required super.id,
    required super.email,
    required super.name,
    required super.avatar,
    required super.role,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }
}

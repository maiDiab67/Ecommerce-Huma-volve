import '../../domain/entities/signup_request_body_entity.dart';

class SignupRequestBody extends SignupRequestBodyEntity {
  SignupRequestBody({
    required super.name,
    required super.email,
    required super.password,
    required super.role,
    required super.avatar,
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

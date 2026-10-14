import '../../domain/entities/login_request_body_entity.dart';

class LoginRequestBody extends LoginRequestBodyEntity {
  LoginRequestBody({super.email, super.password});

  LoginRequestBody.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

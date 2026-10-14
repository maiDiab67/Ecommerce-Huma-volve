import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_body_entity.dart';

class LoginResponse extends LoginResponseBodyEntity {
  LoginResponse({super.accessToken, super.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }
}

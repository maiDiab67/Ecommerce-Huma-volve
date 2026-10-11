import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';

import '../../../../../core/network/api_services.dart';
import '../login_request_body.dart';
import '../models/login_response.dart';

class LoginRepo {
  ApiServices apiServices;

  LoginRepo(this.apiServices);

  Future<LoginResponse> login(LoginRequestBody loginRequestBody) async {
    final response = await apiServices.dio.post(
      ApiEndpoints.login,
      data: loginRequestBody.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}

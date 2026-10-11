import 'package:ecommerce_app_huma_volve/core/network/api_services.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_request_body.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../models/signup_response.dart';

class SignupRepo {
  ApiServices apiServices;

  SignupRepo(this.apiServices);

  Future<SignupResponse> signUp(SignupRequestBody signupRequestBody) async {
    // Implement the signup logic here
    final response = await apiServices.dio.post(
      ApiEndpoints.signUp,
      data: signupRequestBody.toJson(),
    );

    return SignupResponse.fromJson(response.data);
  }
}

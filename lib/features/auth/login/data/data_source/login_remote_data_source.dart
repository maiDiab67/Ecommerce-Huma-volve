import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_request_body.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response.dart';

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(LoginRequestBody loginrequestbody);
}

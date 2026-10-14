import 'package:ecommerce_app_huma_volve/core/network/api_services.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_request_body.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/models/login_response.dart';

import '../../../../../core/constants/api_endpoints.dart';
import '../../../../../core/storage/secure_storage.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiServices apiServices;
  LoginRemoteDataSourceImpl(this.apiServices);
  @override
  Future<LoginResponse> login(LoginRequestBody loginrequestbody) async {
    final response = await apiServices.dio.post(
      ApiEndpoints.login,
      data: loginrequestbody.toJson(),
    );
    await SecureStorage.saveAccessToken(response.data['access_token']);
    await SecureStorage.saveRefreshToken(response.data['refresh_token']);
    return LoginResponse.fromJson(response.data);
  }
}

import '../../../../../core/constants/api_endpoints.dart';
import '../../../../../core/network/api_services.dart';
import '../models/signup_request_body.dart';
import '../models/signup_response.dart';
import 'signup_remote_data_source.dart';

class SignupRemoteDataSourceImpl implements SignupRemoteDataSource {
  ApiServices apiServices;

  SignupRemoteDataSourceImpl(this.apiServices);

  @override
  Future<SignupResponse> signup(SignupRequestBody requestBody) async {
    final response = await apiServices.dio.post(
      ApiEndpoints.signUp,
      data: requestBody.toJson(),
    );

    return SignupResponse.fromJson(response.data);
  }
}

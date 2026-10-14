import '../models/signup_request_body.dart';
import '../models/signup_response.dart';

abstract class SignupRemoteDataSource {
  Future<SignupResponse> signup(SignupRequestBody requestBody);
}

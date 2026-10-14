import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/data/data_source/login_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repo/login_repo.dart';

import '../models/login_request_body.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginResponseBodyEntity>> login(
    LoginRequestBodyEntity loginrequestbody,
  ) async {
    try {
      final requestModel = LoginRequestBody(
        email: loginrequestbody.email,
        password: loginrequestbody.password,
      );
      final response = await remoteDataSource.login(requestModel);
      // await SecureStorage.saveAccessToken(response.accessToken);
      // await SecureStorage.saveRefreshToken(response.refreshToken);

      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

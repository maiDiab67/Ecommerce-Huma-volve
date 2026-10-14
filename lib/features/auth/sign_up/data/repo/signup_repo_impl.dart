import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/data_source/signup_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/data/models/signup_request_body.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_response_entity.dart';

import '../../domain/repo/signup_repo.dart';

class SignupRepoImpl extends SignupRepo {
  final SignupRemoteDataSource remoteDataSource;

  SignupRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, SignupResponseEntity>> signup(
    SignupRequestBodyEntity request,
  ) async {
    try {
      final requestModel = SignupRequestBody(
        name: request.name,
        email: request.email,
        password: request.password,
        role: request.role,
        avatar: request.avatar,
      );

      final response = await remoteDataSource.signup(requestModel);

      return Right(response);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

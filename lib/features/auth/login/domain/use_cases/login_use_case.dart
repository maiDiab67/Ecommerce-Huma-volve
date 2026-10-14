import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/repo/login_repo.dart';

import '../../../../../core/failure/failure.dart';

class LoginUseCase {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  Future<Either<Failure, LoginResponseBodyEntity>> invoke(
    LoginRequestBodyEntity loginRequestBody,
  ) {
    return loginRepo.login(loginRequestBody);
  }
}

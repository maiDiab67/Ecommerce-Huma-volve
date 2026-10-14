import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../entities/signup_request_body_entity.dart';
import '../entities/signup_response_entity.dart';
import '../repo/signup_repo.dart';

class SignupUseCase {
  final SignupRepo repo;

  SignupUseCase(this.repo);

  Future<Either<Failure, SignupResponseEntity>> invoke(
    SignupRequestBodyEntity signupRequestBody,
  ) {
    return repo.signup(signupRequestBody);
  }
}

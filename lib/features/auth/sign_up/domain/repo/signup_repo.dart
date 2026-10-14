import 'package:dartz/dartz.dart';

import '../../../../../core/failure/failure.dart';
import '../entities/signup_request_body_entity.dart';
import '../entities/signup_response_entity.dart';

abstract class SignupRepo {
  Future<Either<Failure, SignupResponseEntity>> signup(
    SignupRequestBodyEntity signupRequestBody,
  );
}

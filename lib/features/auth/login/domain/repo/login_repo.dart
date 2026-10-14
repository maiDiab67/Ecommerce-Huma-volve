import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_response_body_entity.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginResponseBodyEntity>> login(
    LoginRequestBodyEntity loginrequestbody,
  );
}

import 'package:ecommerce_app_huma_volve/features/auth/login/domain/entities/login_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/domain/use_cases/login_use_case.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/presentation/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(LoginRequestBodyEntity request) async {
    emit(LoginLoading());

    final result = await loginUseCase.invoke(request);

    result.fold(
      (failure) {
        emit(LoginFailure(failure.message));
      },
      (response) {
        emit(LoginSuccess(response.accessToken.toString()));
      },
    );
  }
}

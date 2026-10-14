import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/entities/signup_request_body_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/domain/use_cases/signup_use_case.dart';

import 'signup_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  final SignupUseCase signupUseCase;

  SignupCubit(this.signupUseCase) : super(SignUpInitial());

  Future<void> signup(SignupRequestBodyEntity request) async {
    emit(SignUpLoading());

    final result = await signupUseCase.invoke(request);

    result.fold(
      (failure) {
        emit(SignUpFailure(failure.message));
      },
      (response) {
        emit(SignUpSuccess(response.id));
      },
    );
  }
}

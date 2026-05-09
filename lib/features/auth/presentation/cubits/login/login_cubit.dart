import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/domain/entities/user_entity.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitialState());

  final AuthRepo authRepo;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepo.loginWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    result.fold(
      (failure) => emit(LoginErrorState(failure.message)),
      (userEntity) => emit(LoginSuccessState(userEntity)),
    );
  }
}

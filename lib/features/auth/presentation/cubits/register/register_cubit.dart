import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/domain/entities/user_entity.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitialState());

  final AuthRepo authRepo;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoadingState());
    final result = await authRepo.registerWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    result.fold(
      (failure) => emit(RegisterErrorState(failure.message)),
      (userEntity) => emit(RegisterSuccessState(userEntity)),
    );
  }
}

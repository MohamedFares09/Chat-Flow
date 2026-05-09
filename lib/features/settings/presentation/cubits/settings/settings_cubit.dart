
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/settings/domain/entities/settings_user_entity.dart';
import 'package:test_codex/features/settings/domain/repos/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settingsRepo) : super(SettingsInitial());

  final SettingsRepo settingsRepo;
  SettingsUserEntity? currentUser;

  Future<void> getCurrentUser() async {
    emit(SettingsLoadingState());
    final result = await settingsRepo.getCurrentUser();
    result.fold(
      (failure) => emit(SettingsErrorState(failure.message)),
      (user) {
        currentUser = user;
        emit(SettingsSuccessState(user));
      },
    );
  }

  Future<void> logout() async {
    emit(SettingsLogoutLoadingState(currentUser));
    final result = await settingsRepo.logout();
    result.fold(
      (failure) => emit(SettingsErrorState(failure.message)),
      (_) => emit(SettingsLogoutSuccessState()),
    );
  }
}

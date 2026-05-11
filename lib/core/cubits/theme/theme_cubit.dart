import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/theme_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(this.themeService) : super(ThemeInitialState(isDark: true));

  final ThemeService themeService;
  StreamSubscription<dynamic>? _authSubscription;

  void watchSavedTheme() {
    _authSubscription?.cancel();
    _authSubscription = themeService.authStateChanges().listen((user) {
      if (user != null) {
        getSavedTheme();
      }
    });
  }

  Future<void> getSavedTheme() async {
    emit(ThemeLoadingState(isDark: state.isDark));
    try {
      final savedTheme = await themeService.getSavedTheme();
      emit(ThemeChangedState(isDark: savedTheme ?? state.isDark));
    } catch (_) {
      emit(
        ThemeErrorState(
          isDark: state.isDark,
          message: 'Unable to load saved theme.',
        ),
      );
    }
  }

  Future<void> changeTheme({required bool isDark}) async {
    emit(ThemeChangedState(isDark: isDark));
    try {
      await themeService.saveTheme(isDark: isDark);
    } catch (_) {
      emit(
        ThemeErrorState(
          isDark: isDark,
          message: 'Unable to save theme.',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}

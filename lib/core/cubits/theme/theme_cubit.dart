import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitialState(isDark: true));

  void changeTheme({required bool isDark}) {
    emit(ThemeChangedState(isDark: isDark));
  }
}

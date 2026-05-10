part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  const ThemeState({required this.isDark});

  final bool isDark;
}

final class ThemeInitialState extends ThemeState {
  const ThemeInitialState({required super.isDark});
}

final class ThemeChangedState extends ThemeState {
  const ThemeChangedState({required super.isDark});
}

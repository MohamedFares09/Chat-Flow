part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  const ThemeState({required this.isDark});

  final bool isDark;
}

final class ThemeInitialState extends ThemeState {
  const ThemeInitialState({required super.isDark});
}

final class ThemeLoadingState extends ThemeState {
  const ThemeLoadingState({required super.isDark});
}

final class ThemeChangedState extends ThemeState {
  const ThemeChangedState({required super.isDark});
}

final class ThemeErrorState extends ThemeState {
  const ThemeErrorState({
    required super.isDark,
    required this.message,
  });

  final String message;
}

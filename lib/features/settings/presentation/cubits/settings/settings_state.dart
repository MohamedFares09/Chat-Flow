part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsSuccessState extends SettingsState {
  SettingsSuccessState(this.user);

  final SettingsUserEntity user;
}

final class SettingsUpdateLoadingState extends SettingsState {
  SettingsUpdateLoadingState(this.user);

  final SettingsUserEntity? user;
}

final class SettingsUpdateSuccessState extends SettingsState {
  SettingsUpdateSuccessState(this.user);

  final SettingsUserEntity user;
}

final class SettingsLogoutLoadingState extends SettingsState {
  SettingsLogoutLoadingState(this.user);

  final SettingsUserEntity? user;
}

final class SettingsLogoutSuccessState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  SettingsErrorState(this.message);

  final String message;
}

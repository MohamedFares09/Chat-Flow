part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  LoginSuccessState(this.userEntity);

  final UserEntity userEntity;
}

final class LoginErrorState extends LoginState {
  LoginErrorState(this.message);

  final String message;
}

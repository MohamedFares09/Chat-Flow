part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitialState extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  RegisterSuccessState(this.userEntity);

  final UserEntity userEntity;
}

final class RegisterErrorState extends RegisterState {
  RegisterErrorState(this.message);

  final String message;
}

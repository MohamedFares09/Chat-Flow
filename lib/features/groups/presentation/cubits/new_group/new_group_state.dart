part of 'new_group_cubit.dart';

@immutable
sealed class NewGroupState {}

final class NewGroupInitialState extends NewGroupState {}

final class NewGroupLoadingState extends NewGroupState {}

final class NewGroupSearchLoadingState extends NewGroupState {}

final class NewGroupCreateLoadingState extends NewGroupState {}

final class NewGroupSuccessState extends NewGroupState {
  NewGroupSuccessState({required this.contacts, required this.selectedMembers});

  final List<HomeUserEntity> contacts;
  final List<HomeUserEntity> selectedMembers;
}

final class NewGroupCreateSuccessState extends NewGroupState {
  NewGroupCreateSuccessState(this.group);

  final GroupEntity group;
}

final class NewGroupErrorState extends NewGroupState {
  NewGroupErrorState(this.message);

  final String message;
}

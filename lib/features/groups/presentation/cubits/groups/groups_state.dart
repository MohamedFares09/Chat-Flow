part of 'groups_cubit.dart';

@immutable
sealed class GroupsState {}

final class GroupsInitialState extends GroupsState {}

final class GroupsLoadingState extends GroupsState {}

final class GroupsSearchLoadingState extends GroupsState {}

final class GroupsSuccessState extends GroupsState {
  GroupsSuccessState({
    required this.groups,
    required this.contacts,
    required this.searchResults,
  });

  final List<GroupEntity> groups;
  final List<HomeUserEntity> contacts;
  final List<HomeUserEntity> searchResults;
}

final class GroupsErrorState extends GroupsState {
  GroupsErrorState(this.message);

  final String message;
}

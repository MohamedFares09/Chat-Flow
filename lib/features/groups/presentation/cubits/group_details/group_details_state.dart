part of 'group_details_cubit.dart';

@immutable
sealed class GroupDetailsState {}

final class GroupDetailsInitialState extends GroupDetailsState {}

final class GroupDetailsSuccessState extends GroupDetailsState {
  GroupDetailsSuccessState(this.group);

  final GroupEntity group;
}

final class GroupDetailsUpdateLoadingState extends GroupDetailsState {
  GroupDetailsUpdateLoadingState(this.group);

  final GroupEntity group;
}

final class GroupDetailsUpdateSuccessState extends GroupDetailsState {
  GroupDetailsUpdateSuccessState(this.group);

  final GroupEntity group;
}

final class GroupDetailsErrorState extends GroupDetailsState {
  GroupDetailsErrorState(this.message);

  final String message;
}

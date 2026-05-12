import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  GroupDetailsCubit(this.groupsRepo) : super(GroupDetailsInitialState());

  final GroupsRepo groupsRepo;

  StreamSubscription<GroupEntity>? _groupSubscription;
  GroupEntity? group;

  void watchGroup(GroupEntity initialGroup) {
    group = initialGroup;
    emit(GroupDetailsSuccessState(initialGroup));
    _groupSubscription?.cancel();
    _groupSubscription = groupsRepo
        .watchGroup(initialGroup.id)
        .listen(
          (updatedGroup) {
            group = updatedGroup;
            emit(GroupDetailsSuccessState(updatedGroup));
          },
          onError: (_) {
            emit(GroupDetailsErrorState('You are not a member of this group.'));
          },
        );
  }

  Future<void> updateGroup({required String name, String? imagePath}) async {
    final currentGroup = group;
    if (currentGroup == null) {
      emit(GroupDetailsErrorState('Group was not found.'));
      return;
    }

    emit(GroupDetailsUpdateLoadingState(currentGroup));
    final result = await groupsRepo.updateGroupDetails(
      groupId: currentGroup.id,
      name: name,
      imagePath: imagePath,
    );
    result.fold((failure) => emit(GroupDetailsErrorState(failure.message)), (
      updatedGroup,
    ) {
      group = updatedGroup;
      emit(GroupDetailsUpdateSuccessState(updatedGroup));
    });
  }

  @override
  Future<void> close() {
    _groupSubscription?.cancel();
    return super.close();
  }
}

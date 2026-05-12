import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

part 'new_group_state.dart';

class NewGroupCubit extends Cubit<NewGroupState> {
  NewGroupCubit(this.groupsRepo) : super(NewGroupInitialState());

  final GroupsRepo groupsRepo;

  List<HomeUserEntity> contacts = [];
  List<HomeUserEntity> visibleContacts = [];
  List<HomeUserEntity> selectedMembers = [];

  Future<void> getContacts() async {
    emit(NewGroupLoadingState());
    final result = await groupsRepo.getChattedUsers();
    result.fold((failure) => emit(NewGroupErrorState(failure.message)), (
      users,
    ) {
      contacts = users;
      visibleContacts = users;
      _emitSuccess();
    });
  }

  Future<void> searchContacts(String query) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      visibleContacts = contacts;
      _emitSuccess();
      return;
    }

    emit(NewGroupSearchLoadingState());
    final localMatches = contacts.where((user) {
      return user.name.toLowerCase().contains(cleanQuery) ||
          user.email.toLowerCase().contains(cleanQuery);
    }).toList();
    final result = await groupsRepo.searchUsersByEmail(cleanQuery);
    result.fold((failure) => emit(NewGroupErrorState(failure.message)), (
      users,
    ) {
      final merged = <String, HomeUserEntity>{
        for (final user in localMatches) user.uId: user,
        for (final user in users) user.uId: user,
      };
      visibleContacts = merged.values.toList();
      _emitSuccess();
    });
  }

  void toggleMember(HomeUserEntity user) {
    final isSelected = selectedMembers.any((member) => member.uId == user.uId);
    if (isSelected) {
      selectedMembers = selectedMembers
          .where((member) => member.uId != user.uId)
          .toList();
    } else {
      selectedMembers = [...selectedMembers, user];
    }
    _emitSuccess();
  }

  Future<void> createGroup(String name) async {
    emit(NewGroupCreateLoadingState());
    final result = await groupsRepo.createGroup(
      name: name,
      members: selectedMembers,
    );
    result.fold(
      (failure) => emit(NewGroupErrorState(failure.message)),
      (group) => emit(NewGroupCreateSuccessState(group)),
    );
  }

  void _emitSuccess() {
    emit(
      NewGroupSuccessState(
        contacts: visibleContacts,
        selectedMembers: selectedMembers,
      ),
    );
  }
}

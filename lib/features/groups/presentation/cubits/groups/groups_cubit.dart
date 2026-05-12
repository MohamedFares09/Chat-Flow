import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit(this.groupsRepo) : super(GroupsInitialState());

  final GroupsRepo groupsRepo;

  StreamSubscription<List<GroupEntity>>? _groupsSubscription;
  List<GroupEntity> groups = [];
  List<HomeUserEntity> contacts = [];
  List<HomeUserEntity> searchResults = [];

  void watchGroups() {
    emit(GroupsLoadingState());
    _groupsSubscription?.cancel();
    _groupsSubscription = groupsRepo.watchGroups().listen(
      (items) {
        groups = items;
        _emitSuccess();
      },
      onError: (_) {
        emit(GroupsErrorState('Something went wrong. Please try again.'));
      },
    );
    getContacts();
  }

  Future<void> getContacts() async {
    final result = await groupsRepo.getChattedUsers();
    result.fold((failure) => emit(GroupsErrorState(failure.message)), (users) {
      contacts = users;
      _emitSuccess();
    });
  }

  Future<void> searchContacts(String query) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      clearSearch();
      return;
    }

    emit(GroupsSearchLoadingState());
    final localMatches = contacts.where((user) {
      return user.name.toLowerCase().contains(cleanQuery) ||
          user.email.toLowerCase().contains(cleanQuery);
    }).toList();
    final result = await groupsRepo.searchUsersByEmail(cleanQuery);
    result.fold((failure) => emit(GroupsErrorState(failure.message)), (users) {
      final merged = <String, HomeUserEntity>{
        for (final user in localMatches) user.uId: user,
        for (final user in users) user.uId: user,
      };
      searchResults = merged.values.toList();
      _emitSuccess();
    });
  }

  void clearSearch() {
    searchResults = [];
    _emitSuccess();
  }

  void _emitSuccess() {
    emit(
      GroupsSuccessState(
        groups: groups,
        contacts: contacts,
        searchResults: searchResults,
      ),
    );
  }

  @override
  Future<void> close() {
    _groupsSubscription?.cancel();
    return super.close();
  }
}

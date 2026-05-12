import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

part 'group_chat_state.dart';

class GroupChatCubit extends Cubit<GroupChatState> {
  GroupChatCubit(this.groupsRepo) : super(GroupChatInitialState());

  final GroupsRepo groupsRepo;

  StreamSubscription<GroupEntity>? _groupSubscription;
  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  GroupEntity? activeGroup;
  List<MessageEntity> messages = [];

  void openGroup(GroupEntity group) {
    activeGroup = group;
    watchGroup(group.id);
    getMessages(group.id);
  }

  void watchGroup(String groupId) {
    _groupSubscription?.cancel();
    _groupSubscription = groupsRepo
        .watchGroup(groupId)
        .listen(
          (group) {
            activeGroup = group;
            emit(GroupChatGroupUpdatedState(group));
          },
          onError: (_) {
            emit(GroupChatErrorState('You are not a member of this group.'));
          },
        );
  }

  void getMessages(String groupId) {
    emit(GroupChatLoadingState());
    _messagesSubscription?.cancel();
    _messagesSubscription = groupsRepo
        .getGroupMessages(groupId)
        .listen(
          (items) {
            messages = items;
            emit(GroupChatSuccessState(messages));
          },
          onError: (_) {
            emit(GroupChatErrorState('You are not a member of this group.'));
          },
        );
  }

  Future<void> sendMessage({
    required String groupId,
    required String text,
  }) async {
    emit(GroupChatSendLoadingState(messages));
    final result = await groupsRepo.sendGroupMessage(
      groupId: groupId,
      text: text,
    );
    result.fold(
      (failure) => emit(GroupChatErrorState(failure.message)),
      (_) => emit(GroupChatSentState(messages)),
    );
  }

  Future<void> sendMediaMessage({
    required String groupId,
    required String filePath,
    required String type,
    String text = '',
  }) async {
    emit(GroupChatSendLoadingState(messages));
    final result = await groupsRepo.sendGroupMediaMessage(
      groupId: groupId,
      filePath: filePath,
      type: type,
      text: text,
    );
    result.fold(
      (failure) => emit(GroupChatErrorState(failure.message)),
      (_) => emit(GroupChatSentState(messages)),
    );
  }

  @override
  Future<void> close() async {
    await _groupSubscription?.cancel();
    await _messagesSubscription?.cancel();
    return super.close();
  }
}

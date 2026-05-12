part of 'group_chat_cubit.dart';

@immutable
sealed class GroupChatState {}

final class GroupChatInitialState extends GroupChatState {}

final class GroupChatLoadingState extends GroupChatState {}

final class GroupChatSuccessState extends GroupChatState {
  GroupChatSuccessState(this.messages);

  final List<MessageEntity> messages;
}

final class GroupChatGroupUpdatedState extends GroupChatState {
  GroupChatGroupUpdatedState(this.group);

  final GroupEntity group;
}

final class GroupChatSendLoadingState extends GroupChatState {
  GroupChatSendLoadingState(this.messages);

  final List<MessageEntity> messages;
}

final class GroupChatSentState extends GroupChatState {
  GroupChatSentState(this.messages);

  final List<MessageEntity> messages;
}

final class GroupChatErrorState extends GroupChatState {
  GroupChatErrorState(this.message);

  final String message;
}

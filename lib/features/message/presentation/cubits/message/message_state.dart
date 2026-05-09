part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitialState extends MessageState {}

final class MessageLoadingState extends MessageState {}

final class MessageSuccessState extends MessageState {
  MessageSuccessState(this.messages);

  final List<MessageEntity> messages;
}

final class MessageSendLoadingState extends MessageState {
  MessageSendLoadingState(this.messages);

  final List<MessageEntity> messages;
}

final class MessageSentState extends MessageState {
  MessageSentState(this.messages);

  final List<MessageEntity> messages;
}

final class MessageErrorState extends MessageState {
  MessageErrorState(this.message);

  final String message;
}

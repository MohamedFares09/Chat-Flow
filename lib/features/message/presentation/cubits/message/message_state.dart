import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

sealed class MessageState {}

final class MessageInitialState extends MessageState {}

final class MessageLoadingState extends MessageState {}

final class MessageSuccessState extends MessageState {
  MessageSuccessState(this.messages);

  final List<MessageEntity> messages;
}

final class MessageConversationUpdatedState extends MessageState {
  MessageConversationUpdatedState(this.conversation);

  final ConversationEntity conversation;
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

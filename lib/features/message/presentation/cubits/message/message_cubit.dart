import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/repos/message_repo.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.messageRepo) : super(MessageInitialState());

  final MessageRepo messageRepo;
  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  StreamSubscription<ConversationEntity>? _conversationSubscription;
  List<MessageEntity> messages = [];
  ConversationEntity? activeConversation;
  String? activeConversationId;

  void openConversation(ConversationEntity conversation) {
    activeConversation = conversation;
    getMessages(conversation.id);
    watchConversation(conversation.id);
  }

  void getMessages(String conversationId) {
    emit(MessageLoadingState());
    activeConversationId = conversationId;
    updateConversationPresence(
      conversationId: conversationId,
      isOnline: true,
    );
    _messagesSubscription?.cancel();
    _messagesSubscription = messageRepo
        .getMessages(conversationId)
        .listen(
          (items) {
            messages = items;
            emit(MessageSuccessState(messages));
            markConversationAsRead(conversationId);
          },
          onError: (_) {
            emit(MessageErrorState('Something went wrong. Please try again.'));
          },
        );
  }

  void watchConversation(String conversationId) {
    _conversationSubscription?.cancel();
    _conversationSubscription =
        messageRepo.watchConversation(conversationId).listen(
      (conversation) {
        activeConversation = conversation;
        emit(MessageConversationUpdatedState(conversation));
      },
      onError: (_) {
        emit(MessageErrorState('Something went wrong. Please try again.'));
      },
    );
  }

  Future<void> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  }) async {
    emit(MessageSendLoadingState(messages));
    final result = await messageRepo.sendMessage(
      conversationId: conversationId,
      receiverId: receiverId,
      text: text,
    );
    result.fold(
      (failure) => emit(MessageErrorState(failure.message)),
      (_) => emit(MessageSentState(messages)),
    );
  }

  Future<void> sendMediaMessage({
    required String conversationId,
    required String receiverId,
    required String filePath,
    required String type,
    String text = '',
  }) async {
    emit(MessageSendLoadingState(messages));
    final result = await messageRepo.sendMediaMessage(
      conversationId: conversationId,
      receiverId: receiverId,
      filePath: filePath,
      type: type,
      text: text,
    );
    result.fold(
      (failure) => emit(MessageErrorState(failure.message)),
      (_) => emit(MessageSentState(messages)),
    );
  }

  Future<void> markConversationAsRead(String conversationId) async {
    await messageRepo.markConversationAsRead(conversationId);
  }

  Future<void> updateConversationPresence({
    required String conversationId,
    required bool isOnline,
  }) async {
    await messageRepo.updateConversationPresence(
      conversationId: conversationId,
      isOnline: isOnline,
    );
  }

  @override
  Future<void> close() async {
    final conversationId = activeConversationId;
    await _messagesSubscription?.cancel();
    await _conversationSubscription?.cancel();
    if (conversationId != null) {
      await updateConversationPresence(
        conversationId: conversationId,
        isOnline: false,
      );
    }
    return super.close();
  }
}

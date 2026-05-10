import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/repos/message_repo.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit(this.messageRepo) : super(MessageInitialState());

  final MessageRepo messageRepo;
  StreamSubscription<List<MessageEntity>>? _messagesSubscription;
  List<MessageEntity> messages = [];

  void getMessages(String conversationId) {
    emit(MessageLoadingState());
    _messagesSubscription?.cancel();
    _messagesSubscription = messageRepo
        .getMessages(conversationId)
        .listen(
          (items) {
            messages = items;
            emit(MessageSuccessState(messages));
          },
          onError: (_) {
            emit(MessageErrorState('Something went wrong. Please try again.'));
          },
        );
    markConversationAsRead(conversationId);
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

  Future<void> markConversationAsRead(String conversationId) async {
    await messageRepo.markConversationAsRead(conversationId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}

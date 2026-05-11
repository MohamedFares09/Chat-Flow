import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

abstract class MessageRepo {
  Stream<ConversationEntity> watchConversation(String conversationId);

  Stream<List<MessageEntity>> getMessages(String conversationId);

  Future<Either<Failure, Unit>> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  });

  Future<Either<Failure, Unit>> markConversationAsRead(String conversationId);

  Future<Either<Failure, Unit>> updateConversationPresence({
    required String conversationId,
    required bool isOnline,
  });
}

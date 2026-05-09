import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

abstract class MessageRepo {
  Stream<List<MessageEntity>> getMessages(String conversationId);

  Future<Either<Failure, Unit>> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  });

  Future<Either<Failure, Unit>> markConversationAsRead(String conversationId);
}

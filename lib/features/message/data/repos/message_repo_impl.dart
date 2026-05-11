import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/data/services/message_firestore_service.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/repos/message_repo.dart';

class MessageRepoImpl extends MessageRepo {
  MessageRepoImpl({required this.messageFirestoreService});

  final MessageFirestoreService messageFirestoreService;

  @override
  Stream<ConversationEntity> watchConversation(String conversationId) {
    return messageFirestoreService.watchConversation(conversationId);
  }

  @override
  Stream<List<MessageEntity>> getMessages(String conversationId) {
    return messageFirestoreService.getMessages(conversationId);
  }

  @override
  Future<Either<Failure, Unit>> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  }) async {
    try {
      await messageFirestoreService.sendMessage(
        conversationId: conversationId,
        receiverId: receiverId,
        text: text,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception MessageRepoImpl - sendMessage: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> markConversationAsRead(
    String conversationId,
  ) async {
    try {
      await messageFirestoreService.markConversationAsRead(conversationId);
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception MessageRepoImpl - markConversationAsRead: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateConversationPresence({
    required String conversationId,
    required bool isOnline,
  }) async {
    try {
      await messageFirestoreService.updateConversationPresence(
        conversationId: conversationId,
        isOnline: isOnline,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception MessageRepoImpl - updateConversationPresence: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }
}

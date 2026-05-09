import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  Future<Either<Failure, List<HomeUserEntity>>> searchUsersByEmail(
    String email,
  );

  Future<Either<Failure, ConversationEntity>> createConversationWithUser(
    HomeUserEntity user,
  );
}

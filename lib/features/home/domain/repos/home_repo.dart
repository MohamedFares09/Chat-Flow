import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

abstract class HomeRepo {
  Stream<List<ConversationEntity>> watchConversations();

  Future<Either<Failure, List<ConversationEntity>>> getConversations();

  Stream<List<HomeStoryEntity>> watchStoriesForChattedUsers(
    List<ConversationEntity> conversations,
  );

  Future<Either<Failure, Unit>> addStory(String content);

  Future<Either<Failure, Unit>> addMediaStory({
    required String filePath,
    required String type,
    String content,
  });

  Future<Either<Failure, Unit>> markStoryAsSeen(String storyId);

  Future<Either<Failure, List<HomeUserEntity>>> searchUsersByEmail(
    String email,
  );

  Future<Either<Failure, ConversationEntity>> createConversationWithUser(
    HomeUserEntity user,
  );
}

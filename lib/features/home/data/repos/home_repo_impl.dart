import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/home/data/services/home_firestore_service.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl({required this.homeFirestoreService});

  final HomeFirestoreService homeFirestoreService;

  @override
  Stream<List<ConversationEntity>> watchConversations() {
    return homeFirestoreService.watchConversations();
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final conversations = await homeFirestoreService.getConversations();
      return right(conversations);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - getConversations: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Stream<List<HomeStoryEntity>> watchStoriesForChattedUsers(
    List<ConversationEntity> conversations,
  ) {
    return homeFirestoreService.watchStoriesForChattedUsers(conversations);
  }

  @override
  Future<Either<Failure, Unit>> addStory(String content) async {
    try {
      await homeFirestoreService.addStory(content);
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - addStory: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMediaStory({
    required String filePath,
    required String type,
    String content = '',
  }) async {
    try {
      await homeFirestoreService.addMediaStory(
        filePath: filePath,
        type: type,
        content: content,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - addMediaStory: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> markStoryAsSeen(String storyId) async {
    try {
      await homeFirestoreService.markStoryAsSeen(storyId);
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - markStoryAsSeen: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, List<HomeUserEntity>>> searchUsersByEmail(
    String email,
  ) async {
    try {
      final users = await homeFirestoreService.searchUsersByEmail(email);
      return right(users);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - searchUsersByEmail: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> createConversationWithUser(
    HomeUserEntity user,
  ) async {
    try {
      final conversation = await homeFirestoreService.createConversationWithUser(
        user,
      );
      return right(conversation);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception HomeRepoImpl - createConversationWithUser: $e');
      return left(const ServerFailure('Something went wrong. Please try again.'));
    }
  }
}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/groups/data/services/groups_firebase_service.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

class GroupsRepoImpl extends GroupsRepo {
  GroupsRepoImpl({required this.groupsFirebaseService});

  final GroupsFirebaseService groupsFirebaseService;

  @override
  Stream<List<GroupEntity>> watchGroups() {
    return groupsFirebaseService.watchGroups();
  }

  @override
  Future<Either<Failure, List<HomeUserEntity>>> getChattedUsers() async {
    try {
      final users = await groupsFirebaseService.getChattedUsers();
      return right(users);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - getChattedUsers: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<HomeUserEntity>>> searchUsersByEmail(
    String email,
  ) async {
    try {
      final users = await groupsFirebaseService.searchUsersByEmail(email);
      return right(users);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - searchUsersByEmail: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> createGroup({
    required String name,
    required List<HomeUserEntity> members,
  }) async {
    try {
      final group = await groupsFirebaseService.createGroup(
        name: name,
        members: members,
      );
      return right(group);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - createGroup: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Stream<GroupEntity> watchGroup(String groupId) {
    return groupsFirebaseService.watchGroup(groupId);
  }

  @override
  Stream<List<MessageEntity>> getGroupMessages(String groupId) {
    return groupsFirebaseService.getGroupMessages(groupId);
  }

  @override
  Future<Either<Failure, Unit>> sendGroupMessage({
    required String groupId,
    required String text,
  }) async {
    try {
      await groupsFirebaseService.sendGroupMessage(
        groupId: groupId,
        text: text,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - sendGroupMessage: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> sendGroupMediaMessage({
    required String groupId,
    required String filePath,
    required String type,
    String text = '',
  }) async {
    try {
      await groupsFirebaseService.sendGroupMediaMessage(
        groupId: groupId,
        filePath: filePath,
        type: type,
        text: text,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - sendGroupMediaMessage: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateGroupMessage({
    required String groupId,
    required String messageId,
    required String text,
  }) async {
    try {
      await groupsFirebaseService.updateGroupMessage(
        groupId: groupId,
        messageId: messageId,
        text: text,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - updateGroupMessage: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteGroupMessage({
    required String groupId,
    required String messageId,
  }) async {
    try {
      await groupsFirebaseService.deleteGroupMessage(
        groupId: groupId,
        messageId: messageId,
      );
      return right(unit);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - deleteGroupMessage: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }

  @override
  Future<Either<Failure, GroupEntity>> updateGroupDetails({
    required String groupId,
    required String name,
    String? imagePath,
  }) async {
    try {
      final group = await groupsFirebaseService.updateGroupDetails(
        groupId: groupId,
        name: name,
        imagePath: imagePath,
      );
      return right(group);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception GroupsRepoImpl - updateGroupDetails: $e');
      return left(
        const ServerFailure('Something went wrong. Please try again.'),
      );
    }
  }
}

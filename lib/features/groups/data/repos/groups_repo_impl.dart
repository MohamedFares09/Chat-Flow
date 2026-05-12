import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/groups/data/services/groups_firebase_service.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

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
}

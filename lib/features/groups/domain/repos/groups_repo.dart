import 'package:dartz/dartz.dart';
import 'package:test_codex/core/errors/failure.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

abstract class GroupsRepo {
  Stream<List<GroupEntity>> watchGroups();

  Future<Either<Failure, List<HomeUserEntity>>> getChattedUsers();

  Future<Either<Failure, List<HomeUserEntity>>> searchUsersByEmail(
    String email,
  );

  Future<Either<Failure, GroupEntity>> createGroup({
    required String name,
    required List<HomeUserEntity> members,
  });
}

import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class GroupEntity {
  const GroupEntity({
    required this.id,
    required this.name,
    required this.members,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    this.photoUrl,
  });

  final String id;
  final String name;
  final List<HomeUserEntity> members;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String lastMessage;
  final String? photoUrl;
}

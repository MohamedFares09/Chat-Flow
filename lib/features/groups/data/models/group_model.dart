import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/home/data/models/home_user_model.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class GroupModel extends GroupEntity {
  const GroupModel({
    required super.id,
    required super.name,
    required super.members,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
    required super.lastMessage,
  });

  factory GroupModel.fromFirestore({
    required String id,
    required Map<String, dynamic> json,
  }) {
    final memberIds = List<String>.from(json['memberIds'] ?? []);
    final memberNames = Map<String, dynamic>.from(json['memberNames'] ?? {});
    final memberEmails = Map<String, dynamic>.from(json['memberEmails'] ?? {});
    final memberPhotoUrls = Map<String, dynamic>.from(
      json['memberPhotoUrls'] ?? {},
    );

    return GroupModel(
      id: id,
      name: json['name'] ?? 'New Group',
      members: memberIds.map((uId) {
        return HomeUserModel(
          uId: uId,
          name: memberNames[uId] ?? 'Unknown user',
          email: memberEmails[uId] ?? '',
          photoUrl: memberPhotoUrls[uId],
        );
      }).toList(),
      createdBy: json['createdBy'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
      lastMessage: json['lastMessage'] ?? '',
    );
  }

  factory GroupModel.fromEntity(GroupEntity group) {
    return GroupModel(
      id: group.id,
      name: group.name,
      members: group.members,
      createdBy: group.createdBy,
      createdAt: group.createdAt,
      updatedAt: group.updatedAt,
      lastMessage: group.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'memberIds': members.map((user) => user.uId).toList(),
      'memberNames': _memberMap((user) => user.name),
      'memberEmails': _memberMap((user) => user.email),
      'memberPhotoUrls': _memberMap((user) => user.photoUrl),
      'createdBy': createdBy,
      'lastMessage': lastMessage,
    };
  }

  Map<String, dynamic> _memberMap(Object? Function(HomeUserEntity user) value) {
    return {for (final user in members) user.uId: value(user)};
  }
}

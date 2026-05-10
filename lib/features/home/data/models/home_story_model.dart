import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';

class HomeStoryModel extends HomeStoryEntity {
  const HomeStoryModel({
    required super.id,
    required super.uId,
    required super.userName,
    required super.content,
    required super.createdAt,
    super.isMine,
    super.isSeen,
    super.mediaUrl,
    super.type,
    super.photoUrl,
  });

  factory HomeStoryModel.fromFirestore({
    required String id,
    required Map<String, dynamic> json,
    required String currentUserId,
  }) {
    final createdAt = json['createdAt'];
    final viewedBy = List<String>.from(json['viewedBy'] ?? []);
    final isMine = json['uId'] == currentUserId;
    return HomeStoryModel(
      id: id,
      uId: json['uId'] ?? '',
      userName: json['userName'] ?? 'Unknown user',
      content: json['content'] ?? '',
      createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
      isMine: isMine,
      isSeen: isMine || viewedBy.contains(currentUserId),
      mediaUrl: json['mediaUrl'] ?? json['videoUrl'],
      type: json['type'] ?? json['mediaType'] ?? 'text',
      photoUrl: json['photoUrl'],
    );
  }
}

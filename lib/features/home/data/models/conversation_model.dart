import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_codex/features/home/data/models/home_user_model.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.id,
    required super.otherUser,
    required super.lastMessage,
    required super.updatedAt,
    required super.unreadCount,
    required super.isOnline,
  });

  factory ConversationModel.fromFirestore({
    required String id,
    required String currentUserId,
    required Map<String, dynamic> json,
  }) {
    final participantIds = List<String>.from(json['participantIds'] ?? []);
    final otherUserId = participantIds.firstWhere(
      (uId) => uId != currentUserId,
      orElse: () => '',
    );
    final participantNames = Map<String, dynamic>.from(
      json['participantNames'] ?? {},
    );
    final participantEmails = Map<String, dynamic>.from(
      json['participantEmails'] ?? {},
    );
    final unreadCounts = Map<String, dynamic>.from(json['unreadCounts'] ?? {});

    return ConversationModel(
      id: id,
      otherUser: HomeUserModel(
        uId: otherUserId,
        name: participantNames[otherUserId] ?? 'Unknown user',
        email: participantEmails[otherUserId] ?? '',
      ),
      lastMessage: json['lastMessage'] ?? '',
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
      unreadCount: unreadCounts[currentUserId] ?? 0,
      isOnline: json['onlineUsers'] is List &&
          List<String>.from(json['onlineUsers']).contains(otherUserId),
    );
  }
}

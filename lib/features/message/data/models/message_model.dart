import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.text,
    required super.senderId,
    required super.createdAt,
    required super.isMine,
  });

  factory MessageModel.fromFirestore({
    required String id,
    required String currentUserId,
    required Map<String, dynamic> json,
  }) {
    final createdAt = json['createdAt'];
    return MessageModel(
      id: id,
      text: json['text'] ?? '',
      senderId: json['senderId'] ?? '',
      createdAt: createdAt is Timestamp ? createdAt.toDate() : DateTime.now(),
      isMine: json['senderId'] == currentUserId,
    );
  }
}

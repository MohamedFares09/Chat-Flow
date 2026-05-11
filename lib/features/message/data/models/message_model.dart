import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_status.dart';
import 'package:test_codex/features/message/domain/entities/message_type.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.text,
    required super.senderId,
    required super.createdAt,
    required super.isMine,
    required super.status,
    required super.type,
    super.mediaUrl,
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
      status: _statusFromJson(json['status']),
      type: _typeFromJson(json['type']),
      mediaUrl: json['mediaUrl'] is String ? json['mediaUrl'] : null,
    );
  }

  static MessageStatus _statusFromJson(dynamic value) {
    return switch (value) {
      'read' => MessageStatus.read,
      'delivered' => MessageStatus.delivered,
      _ => MessageStatus.sent,
    };
  }

  static MessageType _typeFromJson(dynamic value) {
    return switch (value) {
      'image' => MessageType.image,
      'video' => MessageType.video,
      'voice' => MessageType.voice,
      _ => MessageType.text,
    };
  }
}

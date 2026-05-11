import 'package:test_codex/features/message/domain/entities/message_status.dart';
import 'package:test_codex/features/message/domain/entities/message_type.dart';

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.isMine,
    required this.status,
    required this.type,
    this.mediaUrl,
  });

  final String id;
  final String text;
  final String senderId;
  final DateTime createdAt;
  final bool isMine;
  final MessageStatus status;
  final MessageType type;
  final String? mediaUrl;
}

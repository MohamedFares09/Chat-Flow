import 'package:test_codex/features/message/domain/entities/message_status.dart';

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.isMine,
    required this.status,
  });

  final String id;
  final String text;
  final String senderId;
  final DateTime createdAt;
  final bool isMine;
  final MessageStatus status;
}

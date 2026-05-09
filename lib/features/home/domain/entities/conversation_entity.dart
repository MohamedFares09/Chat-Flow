import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class ConversationEntity {
  const ConversationEntity({
    required this.id,
    required this.otherUser,
    required this.lastMessage,
    required this.updatedAt,
    required this.unreadCount,
    required this.isOnline,
  });

  final String id;
  final HomeUserEntity otherUser;
  final String lastMessage;
  final DateTime? updatedAt;
  final int unreadCount;
  final bool isOnline;
}

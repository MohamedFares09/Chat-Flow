import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeChatTile extends StatelessWidget {
  const HomeChatTile({
    required this.conversation,
    required this.onTap,
    super.key,
  });

  final ConversationEntity conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0x0dffffff)),
        ),
        child: Row(
          children: [
            HomeUserAvatar(
              name: conversation.otherUser.name,
              showOnlineDot: conversation.isOnline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.otherUser.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.title,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      Text(
                        _timeLabel,
                        style: TextStyle(
                          color: conversation.unreadCount > 0
                              ? AppColors.accent
                              : AppColors.body,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage.isEmpty
                              ? 'No messages yet.'
                              : conversation.lastMessage,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.body,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      if (conversation.unreadCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${conversation.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _timeLabel {
    final updatedAt = conversation.updatedAt;
    if (updatedAt == null) {
      return 'Now';
    }

    final now = DateTime.now();
    final difference = now.difference(updatedAt);
    if (difference.inDays == 0) {
      final hour = updatedAt.hour > 12 ? updatedAt.hour - 12 : updatedAt.hour;
      final minute = updatedAt.minute.toString().padLeft(2, '0');
      final period = updatedAt.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    }
    if (difference.inDays == 1) {
      return 'Yesterday';
    }
    return '${difference.inDays}d ago';
  }
}

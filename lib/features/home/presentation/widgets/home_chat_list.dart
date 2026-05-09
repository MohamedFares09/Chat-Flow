import 'package:flutter/material.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_chat_tile.dart';
import 'package:test_codex/features/home/presentation/widgets/home_empty_conversations.dart';

class HomeChatList extends StatelessWidget {
  const HomeChatList({
    required this.conversations,
    required this.onConversationTap,
    super.key,
  });

  final List<ConversationEntity> conversations;
  final ValueChanged<ConversationEntity> onConversationTap;

  @override
  Widget build(BuildContext context) {
    if (conversations.isEmpty) {
      return const HomeEmptyConversations();
    }

    return Column(
      children: conversations
          .map(
            (conversation) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: HomeChatTile(
                conversation: conversation,
                onTap: () => onConversationTap(conversation),
              ),
            ),
          )
          .toList(),
    );
  }
}

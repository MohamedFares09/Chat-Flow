import 'package:flutter/material.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/presentation/widgets/date_chip.dart';
import 'package:test_codex/features/message/presentation/widgets/empty_messages.dart';
import 'package:test_codex/features/message/presentation/widgets/message_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    required this.messages,
    required this.receiverName,
    super.key,
  });

  final List<MessageEntity> messages;
  final String receiverName;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const EmptyMessages();
    }

    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == messages.length) {
          return const DateChip();
        }

        final message = messages[messages.length - index - 1];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MessageBubble(
            message: message,
            receiverName: receiverName,
          ),
        );
      },
    );
  }
}

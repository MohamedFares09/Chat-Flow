import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_cubit.dart';
import 'package:test_codex/features/message/presentation/widgets/message_composer.dart';
import 'package:test_codex/features/message/presentation/widgets/message_header.dart';
import 'package:test_codex/features/message/presentation/widgets/messages_list.dart';

class MessageViewBody extends StatefulWidget {
  const MessageViewBody({
    required this.conversation,
    required this.messages,
    required this.isSending,
    super.key,
  });

  final ConversationEntity conversation;
  final List<MessageEntity> messages;
  final bool isSending;

  @override
  State<MessageViewBody> createState() => _MessageViewBodyState();
}

class _MessageViewBodyState extends State<MessageViewBody> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          children: [
            MessageHeader(conversation: widget.conversation),
            Expanded(
              child: MessagesList(
                messages: widget.messages,
                receiverName: widget.conversation.otherUser.name,
              ),
            ),
            MessageComposer(
              controller: messageController,
              isSending: widget.isSending,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty || widget.isSending) {
      return;
    }
    messageController.clear();
    context.read<MessageCubit>().sendMessage(
          conversationId: widget.conversation.id,
          receiverId: widget.conversation.otherUser.uId,
          text: text,
        );
  }
}

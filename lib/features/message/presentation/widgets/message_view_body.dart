import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_cubit.dart';
import 'package:test_codex/features/message/presentation/widgets/message_attachment_sheet.dart';
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
  final ImagePicker imagePicker = ImagePicker();

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
              onAttachTap: _showAttachmentSheet,
              onCameraTap: _pickCameraImage,
              onVoiceRecorded: _sendVoiceMessage,
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

  Future<void> _showAttachmentSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) {
        return MessageAttachmentSheet(
          onImageTap: () {
            Navigator.pop(sheetContext);
            _pickImage(ImageSource.gallery);
          },
          onVideoTap: () {
            Navigator.pop(sheetContext);
            _pickVideo(ImageSource.gallery);
          },
        );
      },
    );
  }

  Future<void> _pickCameraImage() async {
    await _pickImage(ImageSource.camera);
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await imagePicker.pickImage(source: source);
    if (image == null || widget.isSending) {
      return;
    }

    _sendMediaMessage(filePath: image.path, type: 'image');
  }

  Future<void> _pickVideo(ImageSource source) async {
    final video = await imagePicker.pickVideo(source: source);
    if (video == null || widget.isSending) {
      return;
    }

    _sendMediaMessage(filePath: video.path, type: 'video');
  }

  void _sendVoiceMessage(String filePath) {
    if (widget.isSending) {
      return;
    }

    _sendMediaMessage(filePath: filePath, type: 'voice');
  }

  void _sendMediaMessage({
    required String filePath,
    required String type,
  }) {
    context.read<MessageCubit>().sendMediaMessage(
          conversationId: widget.conversation.id,
          receiverId: widget.conversation.otherUser.uId,
          filePath: filePath,
          type: type,
        );
  }
}

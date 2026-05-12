import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_chat/group_chat_cubit.dart';
import 'package:test_codex/features/groups/presentation/views/group_details_view.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_message_header.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/presentation/widgets/edit_message_sheet.dart';
import 'package:test_codex/features/message/presentation/widgets/message_actions_sheet.dart';
import 'package:test_codex/features/message/presentation/widgets/message_attachment_sheet.dart';
import 'package:test_codex/features/message/presentation/widgets/message_composer.dart';
import 'package:test_codex/features/message/presentation/widgets/messages_list.dart';

class GroupChatViewBody extends StatefulWidget {
  const GroupChatViewBody({
    required this.group,
    required this.messages,
    required this.isSending,
    super.key,
  });

  final GroupEntity group;
  final List<MessageEntity> messages;
  final bool isSending;

  @override
  State<GroupChatViewBody> createState() => _GroupChatViewBodyState();
}

class _GroupChatViewBodyState extends State<GroupChatViewBody> {
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
            GroupMessageHeader(
              group: widget.group,
              onGroupInfoTap: _openGroupDetails,
            ),
            Expanded(
              child: MessagesList(
                messages: widget.messages,
                receiverName: widget.group.name,
                onMessageLongPress: _showMessageActions,
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
    context.read<GroupChatCubit>().sendMessage(
      groupId: widget.group.id,
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

  void _sendMediaMessage({required String filePath, required String type}) {
    context.read<GroupChatCubit>().sendMediaMessage(
      groupId: widget.group.id,
      filePath: filePath,
      type: type,
    );
  }

  void _openGroupDetails() {
    Navigator.pushNamed(
      context,
      GroupDetailsView.route,
      arguments: widget.group,
    );
  }

  Future<void> _showMessageActions(MessageEntity message) async {
    final action = await showModalBottomSheet<MessageAction>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => MessageActionsSheet(message: message),
    );
    if (action == null || !mounted) {
      return;
    }

    switch (action) {
      case MessageAction.edit:
        await _editMessage(message);
      case MessageAction.delete:
        context.read<GroupChatCubit>().deleteMessage(message.id);
    }
  }

  Future<void> _editMessage(MessageEntity message) async {
    final text = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => EditMessageSheet(message: message),
    );
    if (text == null || !mounted) {
      return;
    }
    context.read<GroupChatCubit>().updateMessage(
      messageId: message.id,
      text: text,
    );
  }
}

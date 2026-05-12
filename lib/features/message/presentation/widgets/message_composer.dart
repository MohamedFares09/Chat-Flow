import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/message/presentation/widgets/voice_record_button.dart';

class MessageComposer extends StatelessWidget {
  const MessageComposer({
    required this.controller,
    required this.isSending,
    required this.onSend,
    required this.onAttachTap,
    required this.onCameraTap,
    required this.onVoiceRecorded,
    super.key,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;
  final VoidCallback onAttachTap;
  final VoidCallback onCameraTap;
  final ValueChanged<String> onVoiceRecorded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1a000000),
                    blurRadius: 25,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    color: AppColors.body,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      style: TextStyle(color: AppColors.title, fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(
                          color: AppColors.hint,
                          fontSize: 16,
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                  IconButton(
                    onPressed: isSending ? null : onAttachTap,
                    icon: Icon(Icons.attach_file, color: AppColors.body),
                  ),
                  IconButton(
                    onPressed: isSending ? null : onCameraTap,
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.body,
                    ),
                  ),
                  VoiceRecordButton(
                    isSending: isSending,
                    onVoiceRecorded: onVoiceRecorded,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 48,
            height: 48,
            child: ElevatedButton(
              onPressed: isSending ? null : onSend,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.input,
                shape: const CircleBorder(),
                elevation: 0,
              ),
              child: isSending
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(Icons.send, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }
}

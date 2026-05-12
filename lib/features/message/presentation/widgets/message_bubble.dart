import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_status.dart';
import 'package:test_codex/features/message/domain/entities/message_type.dart';
import 'package:test_codex/features/message/presentation/widgets/message_content.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.message,
    required this.receiverName,
    this.onLongPress,
    super.key,
  });

  final MessageEntity message;
  final String receiverName;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.76,
        ),
        child: Column(
          crossAxisAlignment: message.isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!message.isMine)
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 4),
                child: Text(
                  receiverName,
                  style: const TextStyle(
                    color: Color(0xffcdbdff),
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ),
            GestureDetector(
              onLongPress: message.isMine ? onLongPress : null,
              child: Container(
                padding: _bubblePadding,
                decoration: BoxDecoration(
                  color: message.isMine ? null : const Color(0xff1d2027),
                  gradient: message.isMine
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.purple],
                        )
                      : null,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(message.isMine ? 16 : 0),
                    topRight: Radius.circular(message.isMine ? 0 : 16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: const Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: message.isMine
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.05),
                      blurRadius: message.isMine ? 8 : 1,
                      offset: Offset(0, message.isMine ? 4 : 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MessageContent(message: message, timeLabel: _timeLabel),
                    if (!_hasOverlayMeta) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _timeLabel,
                            style: TextStyle(
                              color: message.isMine
                                  ? Colors.white.withValues(alpha: 0.7)
                                  : AppColors.body.withValues(alpha: 0.6),
                              fontSize: 10,
                              height: 1.5,
                            ),
                          ),
                          if (message.isMine) ...[
                            const SizedBox(width: 4),
                            Icon(_statusIcon, color: _statusColor, size: 14),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _timeLabel {
    final hour = message.createdAt.hour > 12
        ? message.createdAt.hour - 12
        : message.createdAt.hour;
    final safeHour = hour == 0 ? 12 : hour;
    final minute = message.createdAt.minute.toString().padLeft(2, '0');
    final period = message.createdAt.hour >= 12 ? 'PM' : 'AM';
    return '$safeHour:$minute $period';
  }

  IconData get _statusIcon {
    return switch (message.status) {
      MessageStatus.sent => Icons.done,
      MessageStatus.delivered => Icons.done_all,
      MessageStatus.read => Icons.done_all,
    };
  }

  Color get _statusColor {
    return switch (message.status) {
      MessageStatus.read => const Color(0xff60a5fa),
      MessageStatus.sent => const Color(0xffd1d5db),
      MessageStatus.delivered => const Color(0xffd1d5db),
    };
  }

  EdgeInsets get _bubblePadding {
    return switch (message.type) {
      MessageType.image => const EdgeInsets.all(4),
      MessageType.video => const EdgeInsets.all(4),
      _ => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    };
  }

  bool get _hasOverlayMeta {
    return message.type == MessageType.image ||
        message.type == MessageType.video;
  }
}

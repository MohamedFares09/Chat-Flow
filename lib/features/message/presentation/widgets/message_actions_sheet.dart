import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/message/domain/entities/message_entity.dart';
import 'package:test_codex/features/message/domain/entities/message_type.dart';

enum MessageAction { edit, delete }

class MessageActionsSheet extends StatelessWidget {
  const MessageActionsSheet({required this.message, super.key});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    final canEdit = message.type == MessageType.text;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canEdit)
              _ActionTile(
                icon: Icons.edit_outlined,
                title: 'Edit message',
                onTap: () => Navigator.pop(context, MessageAction.edit),
              ),
            _ActionTile(
              icon: Icons.delete_outline,
              title: 'Delete message',
              color: Colors.redAccent,
              onTap: () => Navigator.pop(context, MessageAction.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = color ?? AppColors.title;
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: foregroundColor),
      title: Text(
        title,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
    );
  }
}

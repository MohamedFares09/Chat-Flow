import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/message/presentation/widgets/date_chip.dart';

class EmptyMessages extends StatelessWidget {
  const EmptyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      children:  [
        DateChip(),
        SizedBox(height: 120),
        Icon(
          Icons.chat_bubble_outline,
          color: AppColors.body,
          size: 42,
        ),
        SizedBox(height: 12),
        Text(
          'No messages yet.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Send the first message to start the conversation.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.body,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

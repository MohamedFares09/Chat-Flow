import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeEmptyConversations extends StatelessWidget {
  const HomeEmptyConversations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.chat_bubble_outline,
            color: AppColors.accent,
            size: 42,
          ),
          SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: TextStyle(
              color: AppColors.title,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Search for a user by email to start your first chat.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.body,
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

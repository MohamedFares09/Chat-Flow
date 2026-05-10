import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join the Flow',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Create your account to start seamless\nconversations with your world.',
          style: TextStyle(
            color: AppColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

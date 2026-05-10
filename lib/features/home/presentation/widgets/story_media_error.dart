import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class StoryMediaError extends StatelessWidget {
  const StoryMediaError({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

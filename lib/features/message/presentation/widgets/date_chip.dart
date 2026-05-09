import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class DateChip extends StatelessWidget {
  const DateChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.input.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(999),
        ),
        child: const Text(
          'Today',
          style: TextStyle(
            color: AppColors.body,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            height: 1.33,
          ),
        ),
      ),
    );
  }
}

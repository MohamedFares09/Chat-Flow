import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class NewGroupIdentitySection extends StatelessWidget {
  const NewGroupIdentitySection({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.input,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.hint.withValues(alpha: 0.3),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: AppColors.body,
                size: 34,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.scaffold, width: 2),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'GROUP NAME',
            style: TextStyle(
              color: AppColors.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: AppColors.title, fontSize: 16),
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: 'Enter group name...',
            hintStyle: TextStyle(
              color: AppColors.body.withValues(alpha: 0.5),
              fontSize: 16,
            ),
            suffixIcon: Icon(Icons.mood_outlined, color: AppColors.hint),
            filled: true,
            fillColor: const Color(0xff191c23),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

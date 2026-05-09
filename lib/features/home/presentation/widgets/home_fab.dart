import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 96,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1a000000),
              blurRadius: 15,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.edit, color: Colors.white, size: 20),
      ),
    );
  }
}

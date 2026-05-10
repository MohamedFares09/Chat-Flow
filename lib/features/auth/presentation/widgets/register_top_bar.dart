import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class RegisterTopBar extends StatelessWidget {
  const RegisterTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.scaffold.withValues(alpha: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 4),
           Text(
            'ChatFlow',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.info_outline,
            color: AppColors.body,
            size: 20,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class NewGroupHeader extends StatelessWidget {
  const NewGroupHeader({required this.onDone, super.key});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
            icon: Icon(Icons.arrow_back, color: AppColors.accent),
          ),
          Text(
            'New Group',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onDone,
            icon: Icon(Icons.check, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

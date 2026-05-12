import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class GroupsHeader extends StatelessWidget {
  const GroupsHeader({super.key});

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
          const HomeUserAvatar(name: 'You', size: 40, showOnlineDot: true),
          const SizedBox(width: 16),
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
          Icon(Icons.search, color: AppColors.accent, size: 24),
        ],
      ),
    );
  }
}

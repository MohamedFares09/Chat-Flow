import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/settings/domain/entities/settings_user_entity.dart';
import 'package:test_codex/features/settings/presentation/widgets/settings_profile_avatar.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({
    required this.user,
    super.key,
  });

  final SettingsUserEntity? user;

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
          SettingsProfileAvatar(
            name: user?.name ?? 'User',
            photoUrl: user?.photoUrl,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'ChatFlow',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.body, size: 22),
          ),
        ],
      ),
    );
  }
}

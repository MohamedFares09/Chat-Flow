import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/settings/domain/entities/settings_user_entity.dart';
import 'package:test_codex/features/settings/presentation/widgets/settings_profile_avatar.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({
    required this.user,
    required this.onEditProfile,
    super.key,
  });

  final SettingsUserEntity? user;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    final name = user?.name.trim().isNotEmpty == true ? user!.name : 'User';
    final email = user?.email.trim().isNotEmpty == true
        ? user!.email
        : 'No email found';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 34, 24, 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          SettingsProfileAvatar(
            name: name,
            photoUrl: user?.photoUrl,
            size: 96,
            showOnlineDot: true,
          ),
          const SizedBox(height: 18),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.body,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onEditProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(120, 36),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

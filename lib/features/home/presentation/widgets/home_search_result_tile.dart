import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeSearchResultTile extends StatelessWidget {
  const HomeSearchResultTile({
    required this.user,
    required this.onTap,
    super.key,
  });

  final HomeUserEntity user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: HomeUserAvatar(name: user.name),
      title: Text(
        user.name,
        style: TextStyle(color: AppColors.title),
      ),
      subtitle: Text(
        user.email,
        style: TextStyle(color: AppColors.body),
      ),
      trailing: TextButton.icon(
        onPressed: onTap,
        icon: Icon(Icons.chat_bubble_outline, size: 18),
        label: const Text('Start'),
      ),
    );
  }
}

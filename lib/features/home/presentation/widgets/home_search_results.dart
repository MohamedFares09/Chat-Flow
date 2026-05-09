import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeSearchResults extends StatelessWidget {
  const HomeSearchResults({
    required this.users,
    required this.onStartConversation,
    super.key,
  });

  final List<HomeUserEntity> users;
  final ValueChanged<HomeUserEntity> onStartConversation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: users
            .map(
              (user) => _SearchResultTile(
                user: user,
                onTap: () => onStartConversation(user),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile({
    required this.user,
    required this.onTap,
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
        style: const TextStyle(color: AppColors.title),
      ),
      subtitle: Text(
        user.email,
        style: const TextStyle(color: AppColors.body),
      ),
      trailing: TextButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.chat_bubble_outline, size: 18),
        label: const Text('Start'),
      ),
    );
  }
}

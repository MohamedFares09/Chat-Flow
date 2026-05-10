import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_search_result_tile.dart';

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
              (user) => HomeSearchResultTile(
                user: user,
                onTap: () => onStartConversation(user),
              ),
            )
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class GroupsContactItem extends StatelessWidget {
  const GroupsContactItem({
    required this.user,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  final HomeUserEntity user;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.input : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            HomeUserAvatar(
              name: user.name,
              photoUrl: user.photoUrl,
              size: 48,
              showOnlineDot: isSelected,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name.isEmpty ? user.email : user.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.title,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    isSelected ? 'Selected' : user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected ? AppColors.accent : AppColors.body,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap == null)
              Icon(Icons.chat_bubble_outline, color: AppColors.hint, size: 22)
            else
              _SelectionBox(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isSelected ? AppColors.accent : AppColors.mutedBorder,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 16, color: Color(0xff10131a))
          : null,
    );
  }
}

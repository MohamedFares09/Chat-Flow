import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class NewGroupSelectedChips extends StatelessWidget {
  const NewGroupSelectedChips({
    required this.members,
    required this.onRemove,
    super.key,
  });

  final List<HomeUserEntity> members;
  final ValueChanged<HomeUserEntity> onRemove;

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final member = members[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xff5203d5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
            ),
            child: Row(
              children: [
                HomeUserAvatar(
                  name: member.name,
                  photoUrl: member.photoUrl,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  member.name.isEmpty ? member.email : member.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => onRemove(member),
                  child: Icon(Icons.close, color: AppColors.body, size: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

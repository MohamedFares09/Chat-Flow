import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';

class GroupMessageHeader extends StatelessWidget {
  const GroupMessageHeader({required this.group, super.key});

  final GroupEntity group;

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
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xff5203d5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.groups, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.title,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
                Text(
                  '${group.members.length} MEMBERS',
                  style: TextStyle(
                    color: AppColors.body,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}

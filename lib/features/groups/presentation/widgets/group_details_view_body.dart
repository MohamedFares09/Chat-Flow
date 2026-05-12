import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_details/group_details_cubit.dart';
import 'package:test_codex/features/groups/presentation/models/group_details_update_data.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_avatar.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_details_edit_sheet.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_member_tile.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({required this.group, super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Column(
          children: [
            _GroupDetailsHeader(group: group),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                children: [
                  _GroupProfileCard(
                    group: group,
                    onEdit: () => _showEditSheet(context),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${group.members.length} MEMBERS',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...group.members.map((member) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GroupMemberTile(
                        member: member,
                        isAdmin: member.uId == group.createdBy,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditSheet(BuildContext context) async {
    final result = await showModalBottomSheet<GroupDetailsUpdateData>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => GroupDetailsEditSheet(group: group),
    );
    if (result == null || !context.mounted) {
      return;
    }
    await context.read<GroupDetailsCubit>().updateGroup(
      name: result.name,
      imagePath: result.imagePath,
    );
  }
}

class _GroupDetailsHeader extends StatelessWidget {
  const _GroupDetailsHeader({required this.group});

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
          Expanded(
            child: Text(
              group.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
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

class _GroupProfileCard extends StatelessWidget {
  const _GroupProfileCard({required this.group, required this.onEdit});

  final GroupEntity group;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          GroupAvatar(name: group.name, photoUrl: group.photoUrl, size: 104),
          const SizedBox(height: 16),
          Text(
            group.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.title,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${group.members.length} members',
            style: TextStyle(color: AppColors.body, fontSize: 14),
          ),
          const SizedBox(height: 18),
          OutlinedButton.icon(
            onPressed: onEdit,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accent,
              side: BorderSide(color: AppColors.mutedBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Edit Group'),
          ),
        ],
      ),
    );
  }
}

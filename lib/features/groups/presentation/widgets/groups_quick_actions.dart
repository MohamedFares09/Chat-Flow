import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class GroupsQuickActions extends StatelessWidget {
  const GroupsQuickActions({
    required this.onNewContact,
    required this.onNewGroup,
    super.key,
  });

  final VoidCallback onNewContact;
  final VoidCallback onNewGroup;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            icon: Icons.person_add_alt_1,
            label: 'New Contact',
            color: AppColors.primary,
            onTap: onNewContact,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _QuickActionCard(
            icon: Icons.group_add,
            label: 'New Group',
            color: const Color(0xff5203d5),
            onTap: onNewGroup,
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        height: 74,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

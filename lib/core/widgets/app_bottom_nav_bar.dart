import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.selectedIndex,
    required this.onItemSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          color: AppColors.scaffold.withValues(alpha: 0.85),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          border: const Border(top: BorderSide(color: Color(0x33414754))),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 20,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
              icon: Icons.chat_bubble_outline,
              label: 'Chats',
              isActive: selectedIndex == 0,
              onTap: () => onItemSelected(0),
            ),
            _BottomNavItem(
              icon: Icons.group_outlined,
              label: 'Groups',
              isActive: selectedIndex == 1,
              onTap: () => onItemSelected(1),
            ),
            _BottomNavItem(
              icon: Icons.call_outlined,
              label: 'Calls',
              isActive: selectedIndex == 2,
              onTap: () => onItemSelected(2),
            ),
            _BottomNavItem(
              icon: Icons.settings,
              label: 'Settings',
              isActive: selectedIndex == 3,
              onTap: () => onItemSelected(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accent : AppColors.body;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: SizedBox(
        width: 52,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

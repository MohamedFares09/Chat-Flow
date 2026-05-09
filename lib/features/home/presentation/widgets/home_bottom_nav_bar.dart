import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _BottomNavItem(
              icon: Icons.chat_bubble_outline,
              label: 'Chats',
              isActive: true,
            ),
            _BottomNavItem(icon: Icons.group_outlined, label: 'Groups'),
            _BottomNavItem(icon: Icons.call_outlined, label: 'Calls'),
            _BottomNavItem(icon: Icons.settings_outlined, label: 'Settings'),
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
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accent : AppColors.body;
    return Column(
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
    );
  }
}

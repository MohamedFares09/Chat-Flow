import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class StoryOptionTile extends StatelessWidget {
  const StoryOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.input,
        child: Icon(icon, color: AppColors.accent),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.title,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: AppColors.body),
      ),
      onTap: onTap,
    );
  }
}

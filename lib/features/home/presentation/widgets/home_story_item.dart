import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeStoryItem extends StatelessWidget {
  const HomeStoryItem({
    required this.name,
    this.isAddStory = false,
    super.key,
  });

  final String name;
  final bool isAddStory;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isAddStory
                ? Border.all(color: const Color(0xff414754), width: 2)
                : null,
            gradient: isAddStory
                ? null
                : const LinearGradient(
                    colors: [AppColors.accent, Color(0xffcdbdff)],
                  ),
          ),
          child: isAddStory
              ? const CircleAvatar(
                  backgroundColor: AppColors.input,
                  child: Icon(Icons.add, color: AppColors.accent),
                )
              : HomeUserAvatar(name: name, size: 66),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            color: isAddStory ? AppColors.body : AppColors.title,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

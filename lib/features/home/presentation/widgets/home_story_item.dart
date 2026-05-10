import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeStoryItem extends StatelessWidget {
  const HomeStoryItem({
    required this.name,
    this.isAddStory = false,
    this.isMyStory = false,
    this.isSeen = false,
    this.isLoading = false,
    this.photoUrl,
    this.onTap,
    this.onAddTap,
    super.key,
  });

  final String name;
  final bool isAddStory;
  final bool isMyStory;
  final bool isSeen;
  final bool isLoading;
  final String? photoUrl;
  final VoidCallback? onTap;
  final VoidCallback? onAddTap;

  @override
  Widget build(BuildContext context) {
    final ringPadding = isAddStory || isSeen ? 0.0 : 3.0;
    final avatarSize = 72 - (ringPadding * 2);

    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                padding: EdgeInsets.all(ringPadding),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isAddStory
                      ? Border.all(color: const Color(0xff414754), width: 2)
                      : null,
                  gradient: isAddStory || isSeen
                      ? null
                      : const LinearGradient(
                          colors: [AppColors.accent, Color(0xffcdbdff)],
                        ),
                ),
                child: isAddStory
                    ? CircleAvatar(
                        backgroundColor: AppColors.input,
                        child: isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.add, color: AppColors.accent),
                      )
                    : HomeUserAvatar(
                        name: name,
                        size: avatarSize,
                        photoUrl: photoUrl,
                      ),
              ),
              if (isMyStory)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: onAddTap,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.scaffold, width: 2),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 76,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isAddStory ? AppColors.body : AppColors.title,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

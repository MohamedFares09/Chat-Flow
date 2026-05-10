import 'package:flutter/material.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({
    required this.story,
    required this.progress,
    required this.onClose,
    super.key,
  });

  final HomeStoryEntity story;
  final Animation<double> progress;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 8,
      top: 12,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: AnimatedBuilder(
              animation: progress,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: story.isVideo ? null : progress.value,
                  minHeight: 3,
                  backgroundColor: const Color(0x55ffffff),
                  color: Colors.white,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              HomeUserAvatar(
                name: story.userName,
                photoUrl: story.photoUrl,
                size: 42,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  story.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

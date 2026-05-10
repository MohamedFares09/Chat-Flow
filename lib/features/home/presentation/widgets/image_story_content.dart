import 'package:flutter/material.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/story_media_error.dart';

class ImageStoryContent extends StatelessWidget {
  const ImageStoryContent({
    required this.story,
    super.key,
  });

  final HomeStoryEntity story;

  @override
  Widget build(BuildContext context) {
    final mediaUrl = story.mediaUrl?.trim();
    if (mediaUrl == null || mediaUrl.isEmpty) {
      return const StoryMediaError(message: 'Unable to load this story image.');
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          mediaUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const StoryMediaError(
              message: 'Unable to load this story image.',
            );
          },
        ),
        if (story.content.trim().isNotEmpty)
          Positioned(
            left: 24,
            right: 24,
            bottom: 36,
            child: Text(
              story.content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                shadows: [
                  Shadow(color: Colors.black87, blurRadius: 8),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

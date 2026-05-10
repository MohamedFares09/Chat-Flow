import 'package:flutter/material.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_story_item.dart';

class HomeStoriesSection extends StatelessWidget {
  const HomeStoriesSection({
    required this.stories,
    required this.isAddingStory,
    required this.onAddStory,
    required this.onStoryTap,
    super.key,
  });

  final List<HomeStoryEntity> stories;
  final bool isAddingStory;
  final VoidCallback onAddStory;
  final ValueChanged<HomeStoryEntity> onStoryTap;

  @override
  Widget build(BuildContext context) {
    final myStories = stories.where((story) => story.isMine).toList();
    final otherStories = stories.where((story) => !story.isMine).toList();
    final myStory = myStories.isEmpty ? null : myStories.first;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HomeStoryItem(
            name: myStory == null ? 'Your Story' : 'My Story',
            isAddStory: myStory == null,
            isMyStory: myStory != null,
            isSeen: myStory?.isSeen ?? false,
            isLoading: isAddingStory,
            photoUrl: myStory?.photoUrl,
            onTap: myStory == null ? onAddStory : () => onStoryTap(myStory),
            onAddTap: onAddStory,
          ),
          for (final story in otherStories) ...[
            const SizedBox(width: 16),
            HomeStoryItem(
              name: story.userName,
              photoUrl: story.photoUrl,
              isSeen: story.isSeen,
              onTap: () => onStoryTap(story),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/features/home/presentation/widgets/home_story_item.dart';

class HomeStoriesSection extends StatelessWidget {
  const HomeStoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HomeStoryItem(name: 'Your Story', isAddStory: true),
          SizedBox(width: 16),
          HomeStoryItem(name: 'Sara'),
          SizedBox(width: 16),
          HomeStoryItem(name: 'Mohamed'),
          SizedBox(width: 16),
          HomeStoryItem(name: 'Nour'),
          SizedBox(width: 16),
          HomeStoryItem(name: 'Ali'),
        ],
      ),
    );
  }
}

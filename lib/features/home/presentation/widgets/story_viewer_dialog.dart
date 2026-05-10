import 'package:flutter/material.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/image_story_content.dart';
import 'package:test_codex/features/home/presentation/widgets/story_header.dart';
import 'package:test_codex/features/home/presentation/widgets/text_story_content.dart';
import 'package:test_codex/features/home/presentation/widgets/video_story_player.dart';

class StoryViewerDialog extends StatefulWidget {
  const StoryViewerDialog({
    required this.story,
    super.key,
  });

  final HomeStoryEntity story;

  @override
  State<StoryViewerDialog> createState() => _StoryViewerDialogState();
}

class _StoryViewerDialogState extends State<StoryViewerDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController progressController;

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    if (!widget.story.isVideo) {
      progressController
        ..addStatusListener(_progressStatusListener)
        ..forward();
    }
  }

  @override
  void dispose() {
    progressController
      ..removeStatusListener(_progressStatusListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: widget.story.isVideo
                  ? VideoStoryPlayer(
                      story: widget.story,
                      onFinished: _closeStory,
                    )
                  : widget.story.isImage
                      ? ImageStoryContent(story: widget.story)
                      : TextStoryContent(story: widget.story),
            ),
            StoryHeader(
              story: widget.story,
              progress: progressController,
              onClose: _closeStory,
            ),
          ],
        ),
      ),
    );
  }

  void _closeStory() {
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  void _progressStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _closeStory();
    }
  }
}

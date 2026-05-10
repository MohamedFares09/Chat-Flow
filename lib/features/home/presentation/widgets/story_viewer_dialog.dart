import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';
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
                      ? _ImageStoryContent(story: widget.story)
                  : _TextStoryContent(story: widget.story),
            ),
            _StoryHeader(
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

class _ImageStoryContent extends StatelessWidget {
  const _ImageStoryContent({required this.story});

  final HomeStoryEntity story;

  @override
  Widget build(BuildContext context) {
    final mediaUrl = story.mediaUrl?.trim();
    if (mediaUrl == null || mediaUrl.isEmpty) {
      return const _StoryMediaError(message: 'Unable to load this story image.');
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          mediaUrl,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const _StoryMediaError(
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
              style: const TextStyle(
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

class _StoryMediaError extends StatelessWidget {
  const _StoryMediaError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.title,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StoryHeader extends StatelessWidget {
  const _StoryHeader({
    required this.story,
    required this.progress,
    required this.onClose,
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

class _TextStoryContent extends StatelessWidget {
  const _TextStoryContent({required this.story});

  final HomeStoryEntity story;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 120, 24, 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.purple],
        ),
      ),
      child: Center(
        child: Text(
          story.content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
      ),
    );
  }
}

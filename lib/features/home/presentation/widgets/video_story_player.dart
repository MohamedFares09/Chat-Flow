import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';

class VideoStoryPlayer extends StatefulWidget {
  const VideoStoryPlayer({
    required this.story,
    required this.onFinished,
    super.key,
  });

  final HomeStoryEntity story;
  final VoidCallback onFinished;

  @override
  State<VideoStoryPlayer> createState() => _VideoStoryPlayerState();
}

class _VideoStoryPlayerState extends State<VideoStoryPlayer> {
  VideoPlayerController? controller;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    controller?.removeListener(_videoListener);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoController = controller;
    if (hasError || widget.story.mediaUrl?.trim().isEmpty != false) {
      return const _VideoStoryError();
    }

    if (videoController == null || !videoController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: videoController.value.size.width,
            height: videoController.value.size.height,
            child: VideoPlayer(videoController),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          bottom: 24,
          child: VideoProgressIndicator(
            videoController,
            allowScrubbing: false,
            colors: const VideoProgressColors(
              playedColor: Colors.white,
              bufferedColor: Colors.white54,
              backgroundColor: Colors.white24,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _initializeVideo() async {
    final mediaUrl = widget.story.mediaUrl?.trim();
    if (mediaUrl == null || mediaUrl.isEmpty) {
      setState(() => hasError = true);
      return;
    }

    final videoController = VideoPlayerController.networkUrl(
      Uri.parse(mediaUrl),
    );
    controller = videoController;
    try {
      await videoController.initialize();
      videoController
        ..addListener(_videoListener)
        ..play();
      if (mounted) {
        setState(() {});
      }
    } catch (_) {
      if (mounted) {
        setState(() => hasError = true);
      }
    }
  }

  void _videoListener() {
    final videoController = controller;
    if (videoController == null || !videoController.value.isInitialized) {
      return;
    }
    if (videoController.value.position >= videoController.value.duration) {
      widget.onFinished();
    }
  }
}

class _VideoStoryError extends StatelessWidget {
  const _VideoStoryError();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Unable to play this video story.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

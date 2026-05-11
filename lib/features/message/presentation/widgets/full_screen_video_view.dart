import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_codex/features/message/presentation/widgets/message_duration_label.dart';
import 'package:test_codex/features/message/presentation/widgets/message_media_cache.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoView extends StatefulWidget {
  const FullScreenVideoView({
    required this.videoUrl,
    super.key,
  });

  final String videoUrl;

  @override
  State<FullScreenVideoView> createState() => _FullScreenVideoViewState();
}

class _FullScreenVideoViewState extends State<FullScreenVideoView> {
  VideoPlayerController? _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void dispose() {
    _controller
      ?..removeListener(_onVideoChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final position = controller?.value.position ?? Duration.zero;
    final duration = controller?.value.duration ?? Duration.zero;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _isReady
                  ? AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                children: [
                  Slider(
                    value: _sliderValue(position, duration),
                    max: _sliderMax(duration),
                    onChanged: _isReady
                        ? (value) {
                            controller?.seekTo(
                              Duration(milliseconds: value.round()),
                            );
                          }
                        : null,
                  ),
                  Row(
                    children: [
                      Text(
                        MessageDurationLabel.format(position),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const Spacer(),
                      Text(
                        MessageDurationLabel.format(duration),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _isReady ? () => _seekBy(-10) : null,
                        color: Colors.white,
                        icon: const Icon(Icons.replay_10),
                      ),
                      const SizedBox(width: 16),
                      IconButton.filled(
                        onPressed: _isReady ? _togglePlayback : null,
                        iconSize: 34,
                        icon: Icon(
                          controller?.value.isPlaying == true
                              ? Icons.pause
                              : Icons.play_arrow,
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: _isReady ? () => _seekBy(10) : null,
                        color: Colors.white,
                        icon: const Icon(Icons.forward_10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _sliderValue(Duration position, Duration duration) {
    if (duration.inMilliseconds <= 0) {
      return 0;
    }

    return position.inMilliseconds.clamp(0, duration.inMilliseconds).toDouble();
  }

  double _sliderMax(Duration duration) {
    if (duration.inMilliseconds <= 0) {
      return 1;
    }

    return duration.inMilliseconds.toDouble();
  }

  void _togglePlayback() {
    final controller = _controller;
    if (controller == null) {
      return;
    }

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  void _seekBy(int seconds) {
    final controller = _controller;
    if (controller == null) {
      return;
    }

    final duration = controller.value.duration;
    final nextPosition = controller.value.position + Duration(seconds: seconds);
    final safePosition = Duration(
      milliseconds: nextPosition.inMilliseconds.clamp(
        0,
        duration.inMilliseconds,
      ),
    );
    controller.seekTo(safePosition);
  }

  void _onVideoChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadVideo() async {
    final fileInfo = await MessageMediaCache.instance.getFileFromCache(
      widget.videoUrl,
    );
    final File videoFile;
    if (fileInfo != null) {
      videoFile = fileInfo.file;
    } else {
      videoFile = await MessageMediaCache.instance.getSingleFile(
        widget.videoUrl,
      );
    }

    if (!mounted) {
      return;
    }

    final controller = VideoPlayerController.file(videoFile)
      ..addListener(_onVideoChanged);
    _controller = controller;
    await controller.initialize();
    if (!mounted) {
      return;
    }

    setState(() => _isReady = true);
  }
}

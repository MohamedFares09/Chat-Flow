import 'package:flutter/material.dart';
import 'package:test_codex/features/message/presentation/widgets/cached_message_video_controller.dart';
import 'package:test_codex/features/message/presentation/widgets/full_screen_video_view.dart';
import 'package:test_codex/features/message/presentation/widgets/message_duration_label.dart';
import 'package:video_player/video_player.dart';

class MessageVideoContent extends StatefulWidget {
  const MessageVideoContent({
    required this.videoUrl,
    required this.timeLabel,
    super.key,
  });

  final String videoUrl;
  final String timeLabel;

  @override
  State<MessageVideoContent> createState() => _MessageVideoContentState();
}

class _MessageVideoContentState extends State<MessageVideoContent> {
  VideoPlayerController? _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return GestureDetector(
      onTap: () => _openFullScreenVideo(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 200,
          height: 130,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: _isReady
                    ? FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller!.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      )
                    : const ColoredBox(color: Color(0xff111827)),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color(0x66000000),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _isReady ? _togglePlayback : null,
                  color: Colors.white,
                  iconSize: 34,
                  icon: Icon(
                    controller?.value.isPlaying == true
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Row(
                  children: [
                    const Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      MessageDurationLabel.format(
                        controller?.value.duration ?? Duration.zero,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        child: Text(
                          widget.timeLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.open_in_full,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  void _openFullScreenVideo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoView(videoUrl: widget.videoUrl),
      ),
    );
  }

  Future<void> _loadVideo() async {
    final controller = await CachedMessageVideoController.create(
      widget.videoUrl,
    );
    if (!mounted) {
      controller.dispose();
      return;
    }

    await controller.initialize();
    if (!mounted) {
      controller.dispose();
      return;
    }

    _controller = controller;
    setState(() => _isReady = true);
  }
}

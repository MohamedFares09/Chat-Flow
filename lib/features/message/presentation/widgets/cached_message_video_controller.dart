import 'package:test_codex/features/message/presentation/widgets/message_media_cache.dart';
import 'package:video_player/video_player.dart';

class CachedMessageVideoController {
  const CachedMessageVideoController._();

  static Future<VideoPlayerController> create(String videoUrl) async {
    final fileInfo = await MessageMediaCache.instance.getFileFromCache(
      videoUrl,
    );
    final videoFile = fileInfo?.file ??
        await MessageMediaCache.instance.getSingleFile(videoUrl);
    return VideoPlayerController.file(videoFile);
  }
}

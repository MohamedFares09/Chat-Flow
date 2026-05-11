import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_codex/features/message/presentation/widgets/message_media_cache.dart';

class FullScreenImageView extends StatelessWidget {
  const FullScreenImageView({
    required this.imageUrl,
    required this.heroTag,
    super.key,
  });

  final String imageUrl;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: heroTag,
          child: InteractiveViewer(
            minScale: 0.8,
            maxScale: 4,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              cacheManager: MessageMediaCache.instance,
              fit: BoxFit.contain,
              placeholder: (context, url) {
                return const Center(child: CircularProgressIndicator());
              },
              errorWidget: (context, url, error) {
                return const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white,
                  size: 42,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

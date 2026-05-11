import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MessageMediaCache {
  const MessageMediaCache._();

  static final CacheManager instance = CacheManager(
        Config(
          'chatFlowMessageMedia',
          stalePeriod: const Duration(days: 30),
          maxNrOfCacheObjects: 300,
        ),
      );
}

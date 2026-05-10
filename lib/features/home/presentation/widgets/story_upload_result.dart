import 'package:test_codex/features/home/presentation/widgets/story_upload_type.dart';

class StoryUploadResult {
  const StoryUploadResult({
    required this.type,
    this.content = '',
    this.filePath,
  });

  final StoryUploadType type;
  final String content;
  final String? filePath;
}

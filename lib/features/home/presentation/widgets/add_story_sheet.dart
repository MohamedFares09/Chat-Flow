import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/story_option_tile.dart';
import 'package:test_codex/features/home/presentation/widgets/story_upload_result.dart';
import 'package:test_codex/features/home/presentation/widgets/story_upload_type.dart';
import 'package:test_codex/features/home/presentation/widgets/text_story_dialog.dart';

class AddStorySheet extends StatelessWidget {
  const AddStorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration:  BoxDecoration(
          color: AppColors.scaffold,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Create story',
              style: TextStyle(
                color: AppColors.title,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            StoryOptionTile(
              icon: Icons.text_fields,
              title: 'Text',
              subtitle: 'Write a short status',
              onTap: () => _createTextStory(context),
            ),
            StoryOptionTile(
              icon: Icons.photo_outlined,
              title: 'Photo',
              subtitle: 'Choose image from gallery',
              onTap: () => _pickMedia(context, StoryUploadType.image),
            ),
            StoryOptionTile(
              icon: Icons.videocam_outlined,
              title: 'Video',
              subtitle: 'Choose video from gallery',
              onTap: () => _pickMedia(context, StoryUploadType.video),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createTextStory(BuildContext context) async {
    final result = await showDialog<StoryUploadResult>(
      context: context,
      builder: (context) => const TextStoryDialog(),
    );
    if (result == null || !context.mounted) {
      return;
    }
    Navigator.pop(context, result);
  }

  Future<void> _pickMedia(
    BuildContext context,
    StoryUploadType type,
  ) async {
    final picker = ImagePicker();
    final file = type == StoryUploadType.image
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickVideo(source: ImageSource.gallery);
    if (file == null || !context.mounted) {
      return;
    }
    Navigator.pop(
      context,
      StoryUploadResult(
        type: type,
        filePath: file.path,
      ),
    );
  }
}

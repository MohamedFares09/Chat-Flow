import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/story_upload_result.dart';
import 'package:test_codex/features/home/presentation/widgets/story_upload_type.dart';

class TextStoryDialog extends StatefulWidget {
  const TextStoryDialog({super.key});

  @override
  State<TextStoryDialog> createState() => _TextStoryDialogState();
}

class _TextStoryDialogState extends State<TextStoryDialog> {
  final TextEditingController storyController = TextEditingController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.scaffold,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text(
        'Text Story',
        style: TextStyle(color: AppColors.title),
      ),
      content: TextField(
        controller: storyController,
        autofocus: true,
        maxLines: 4,
        maxLength: 180,
        style: const TextStyle(color: AppColors.title),
        decoration: const InputDecoration(
          hintText: 'Write your story...',
          hintStyle: TextStyle(color: AppColors.hint),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mutedBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final content = storyController.text.trim();
            if (content.isEmpty) {
              return;
            }
            Navigator.pop(
              context,
              StoryUploadResult(
                type: StoryUploadType.text,
                content: content,
              ),
            );
          },
          child: const Text('Share'),
        ),
      ],
    );
  }
}

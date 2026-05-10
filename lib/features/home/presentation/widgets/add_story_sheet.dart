import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class AddStorySheet extends StatelessWidget {
  const AddStorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: AppColors.scaffold,
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create story',
              style: TextStyle(
                color: AppColors.title,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            _StoryOptionTile(
              icon: Icons.text_fields,
              title: 'Text',
              subtitle: 'Write a short status',
              onTap: () => _createTextStory(context),
            ),
            _StoryOptionTile(
              icon: Icons.photo_outlined,
              title: 'Photo',
              subtitle: 'Choose image from gallery',
              onTap: () => _pickMedia(context, StoryUploadType.image),
            ),
            _StoryOptionTile(
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
      builder: (context) => const _TextStoryDialog(),
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

class _StoryOptionTile extends StatelessWidget {
  const _StoryOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppColors.input,
        child: Icon(icon, color: AppColors.accent),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.title,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppColors.body),
      ),
      onTap: onTap,
    );
  }
}

class _TextStoryDialog extends StatefulWidget {
  const _TextStoryDialog();

  @override
  State<_TextStoryDialog> createState() => _TextStoryDialogState();
}

class _TextStoryDialogState extends State<_TextStoryDialog> {
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

enum StoryUploadType { text, image, video }

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

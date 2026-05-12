import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class MessageAttachmentSheet extends StatelessWidget {
  const MessageAttachmentSheet({
    required this.onImageTap,
    required this.onVideoTap,
    super.key,
  });

  final VoidCallback onImageTap;
  final VoidCallback onVideoTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AttachmentTile(
              icon: Icons.image_outlined,
              title: 'Image',
              onTap: onImageTap,
            ),
            const SizedBox(height: 8),
            _AttachmentTile(
              icon: Icons.videocam_outlined,
              title: 'Video',
              onTap: onVideoTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentTile extends StatelessWidget {
  const _AttachmentTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withValues(alpha: 0.12),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColors.title, fontWeight: FontWeight.w600),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.border),
      ),
    );
  }
}

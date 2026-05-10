import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class VideoStoryError extends StatelessWidget {
  const VideoStoryError({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Unable to play this video story.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

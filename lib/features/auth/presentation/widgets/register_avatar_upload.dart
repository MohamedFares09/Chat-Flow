import 'package:flutter/material.dart';
import 'package:test_codex/core/widgets/custom_asset_image.dart';
import 'package:test_codex/core/utils/app_images.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class RegisterAvatarUpload extends StatelessWidget {
  const RegisterAvatarUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.input,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: const Color(0xff414754),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const Opacity(
                      opacity: 0.5,
                      child: CustomAssetImage(
                        AppImages.registerProfile,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ColoredBox(
                      color: AppColors.scaffold.withValues(alpha: 0.4),
                    ),
                     Center(
                      child: Icon(
                        Icons.photo_camera_outlined,
                        color: AppColors.accent,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: -2,
              bottom: -2,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
         Text(
          'UPLOAD PHOTO',
          style: TextStyle(
            color: AppColors.body,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

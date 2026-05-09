import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

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
                color: AuthColors.input,
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
                      child: AuthAssetImage(
                        AuthAssets.profilePlaceholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ColoredBox(
                      color: AuthColors.scaffold.withValues(alpha: 0.4),
                    ),
                    const Center(
                      child: AuthAssetImage(
                        AuthAssets.cameraIcon,
                        width: 25,
                        height: 23,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: -2,
              bottom: -2,
              child: AuthAssetImage(
                AuthAssets.avatarAdd,
                width: 45,
                height: 53,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'UPLOAD PHOTO',
          style: TextStyle(
            color: AuthColors.body,
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

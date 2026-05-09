import 'package:flutter/material.dart';
import 'package:test_codex/core/widgets/custom_asset_image.dart';
import 'package:test_codex/core/utils/app_images.dart';

class RegisterFooterGraphics extends StatelessWidget {
  const RegisterFooterGraphics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAssetImage(AppImages.footerCloud, width: 59, height: 43),
          SizedBox(width: 24),
          CustomAssetImage(AppImages.footerRocket, width: 40, height: 40),
          SizedBox(width: 24),
          CustomAssetImage(AppImages.footerStars, width: 59, height: 59),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_images.dart';
import 'package:test_codex/core/widgets/custom_asset_image.dart';

class LoginDecorationGraphics extends StatelessWidget {
  const LoginDecorationGraphics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAssetImage(AppImages.loginDecorationLeft, width: 59, height: 43),
          SizedBox(width: 24),
          CustomAssetImage(
            AppImages.loginDecorationMiddle,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 24),
          CustomAssetImage(
            AppImages.loginDecorationRight,
            width: 59,
            height: 59,
          ),
        ],
      ),
    );
  }
}

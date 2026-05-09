import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';

class RegisterFooterGraphics extends StatelessWidget {
  const RegisterFooterGraphics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthAssetImage(AuthAssets.footerCloud, width: 59, height: 43),
          SizedBox(width: 24),
          AuthAssetImage(AuthAssets.footerRocket, width: 40, height: 40),
          SizedBox(width: 24),
          AuthAssetImage(AuthAssets.footerStars, width: 59, height: 59),
        ],
      ),
    );
  }
}

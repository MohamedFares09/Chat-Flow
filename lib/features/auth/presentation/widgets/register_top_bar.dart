import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class RegisterTopBar extends StatelessWidget {
  const RegisterTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AuthColors.scaffold.withValues(alpha: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const AuthAssetImage(
              AuthAssets.backIcon,
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'ChatFlow',
            style: TextStyle(
              color: AuthColors.accent,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const Spacer(),
          const AuthAssetImage(AuthAssets.infoIcon, width: 20, height: 20),
        ],
      ),
    );
  }
}

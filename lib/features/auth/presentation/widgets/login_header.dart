import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AuthColors.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a000000),
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: const Center(
            child: AuthAssetImage(
              AuthAssets.chatIcon,
              width: 34,
              height: 34,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'ChatFlow',
          style: TextStyle(
            color: AuthColors.title,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Securely connect with your team and\nfriends across the globe.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AuthColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

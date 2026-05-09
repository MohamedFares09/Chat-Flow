import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class AuthDividerText extends StatelessWidget {
  const AuthDividerText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0x4d414754))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(
              color: AuthColors.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0x4d414754))),
      ],
    );
  }
}

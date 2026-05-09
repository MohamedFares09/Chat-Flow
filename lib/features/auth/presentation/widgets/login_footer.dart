import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({required this.onRegisterTap, super.key});

  final VoidCallback onRegisterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: AppColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: const Text(
            'Register',
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

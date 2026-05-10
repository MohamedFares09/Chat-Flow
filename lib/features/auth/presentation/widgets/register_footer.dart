import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/views/login_view.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          'Already have an account? ',
          style: TextStyle(
            color: AppColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, LoginView.route),
          child:  Text(
            'Log In',
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

import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.text,
    required this.onPressed,
    this.borderRadius = 12,
    super.key,
  });

  final String text;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AuthColors.primary,
          disabledBackgroundColor: AuthColors.primary.withValues(alpha: 0.5),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

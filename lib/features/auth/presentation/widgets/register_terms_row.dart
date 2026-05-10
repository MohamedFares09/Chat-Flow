import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class RegisterTermsRow extends StatelessWidget {
  const RegisterTermsRow({
    required this.agreedToTerms,
    required this.onChanged,
    super.key,
  });

  final bool agreedToTerms;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 24,
          child: Checkbox(
            value: agreedToTerms,
            onChanged: onChanged,
            side: BorderSide(color: Color(0xff414754)),
            activeColor: AppColors.primary,
            checkColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppColors.body,
                fontSize: 14,
                height: 1.43,
              ),
              children: [
                const TextSpan(text: 'By signing up, you agree to our '),
                _linkSpan('Terms of\nService'),
                const TextSpan(text: ' and '),
                _linkSpan('Privacy Policy'),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextSpan _linkSpan(String text) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: AppColors.accent,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
        decorationColor: Color(0x4dadc7ff),
      ),
    );
  }
}

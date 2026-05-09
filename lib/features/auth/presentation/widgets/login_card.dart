import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/validators.dart';
import 'package:test_codex/core/widgets/custom_button.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_divider_text.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_text_form_field.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    required this.formKey,
    required this.autovalidateMode,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final FormFieldSetter<String> onEmailSaved;
  final FormFieldSetter<String> onPasswordSaved;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(33),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 50,
            offset: Offset(0, 25),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            CustomTextFormField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              onSaved: onEmailSaved,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              hintText: 'Password',
              obscureText: true,
              onSaved: onPasswordSaved,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  buildSnackBar(
                    context,
                    message: 'Password reset will be added soon.',
                    color: AppColors.primary,
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(text: 'Sign In', onPressed: onSubmit),
            const SizedBox(height: 16),
            const AuthDividerText(),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                buildSnackBar(
                  context,
                  message: 'Google sign in needs google_sign_in setup.',
                  color: AppColors.primary,
                );
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromHeight(56),
                side: const BorderSide(color: AppColors.mutedBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata,
                    color: AppColors.title,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: AppColors.title,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_button.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_divider_text.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_text_form_field.dart';

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
        color: AuthColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuthColors.border),
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
            AuthTextFormField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              onSaved: onEmailSaved,
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            AuthTextFormField(
              hintText: 'Password',
              obscureText: true,
              onSaved: onPasswordSaved,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showAuthSnackBar(
                    context,
                    message: 'Password reset will be added soon.',
                    color: AuthColors.primary,
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AuthColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthButton(text: 'Sign In', onPressed: onSubmit),
            const SizedBox(height: 16),
            const AuthDividerText(),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                showAuthSnackBar(
                  context,
                  message: 'Google sign in needs google_sign_in setup.',
                  color: AuthColors.primary,
                );
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromHeight(56),
                side: const BorderSide(color: AuthColors.mutedBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthAssetImage(AuthAssets.google, width: 20, height: 20),
                  SizedBox(width: 8),
                  Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: AuthColors.title,
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

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
}

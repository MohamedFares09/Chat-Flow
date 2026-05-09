import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/validators.dart';
import 'package:test_codex/core/utils/app_images.dart';
import 'package:test_codex/core/widgets/custom_button.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_avatar_upload.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_labeled_field.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_terms_row.dart';

class RegisterCard extends StatelessWidget {
  const RegisterCard({
    required this.formKey,
    required this.autovalidateMode,
    required this.agreedToTerms,
    required this.onTermsChanged,
    required this.onNameSaved,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onConfirmSaved,
    required this.onSubmit,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final bool agreedToTerms;
  final ValueChanged<bool?> onTermsChanged;
  final FormFieldSetter<String> onNameSaved;
  final FormFieldSetter<String> onEmailSaved;
  final FormFieldSetter<String> onPasswordSaved;
  final FormFieldSetter<String> onConfirmSaved;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 34),
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
            const RegisterAvatarUpload(),
            const SizedBox(height: 32),
            RegisterLabeledField(
              label: 'FULL NAME',
              hintText: 'Alex Rivers',
              prefixAsset: AppImages.userIcon,
              onSaved: onNameSaved,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'EMAIL ADDRESS',
              hintText: 'alex@chatflow.io',
              prefixAsset: AppImages.emailIcon,
              keyboardType: TextInputType.emailAddress,
              onSaved: onEmailSaved,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'PASSWORD',
              hintText: 'Password',
              prefixAsset: AppImages.lockIcon,
              obscureText: true,
              onSaved: onPasswordSaved,
              validator: Validators.password,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'CONFIRM PASSWORD',
              hintText: 'Confirm password',
              prefixAsset: AppImages.shieldIcon,
              obscureText: true,
              onSaved: onConfirmSaved,
              validator: Validators.password,
            ),
            const SizedBox(height: 24),
            RegisterTermsRow(
              agreedToTerms: agreedToTerms,
              onChanged: onTermsChanged,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Create Account',
              borderRadius: 16,
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

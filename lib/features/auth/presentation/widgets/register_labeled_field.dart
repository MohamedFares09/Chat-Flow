import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/widgets/custom_text_form_field.dart';

class RegisterLabeledField extends StatelessWidget {
  const RegisterLabeledField({
    required this.label,
    required this.hintText,
    required this.onSaved,
    required this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    super.key,
  });

  final String label;
  final String hintText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Widget prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              height: 1.33,
            ),
          ),
        ),
        const SizedBox(height: 4),
        CustomTextFormField(
          hintText: hintText,
          onSaved: onSaved,
          validator: validator,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
          obscureText: obscureText,
          fillColor: AppColors.registerInput,
          borderRadius: 16,
          hasBorder: true,
        ),
      ],
    );
  }
}

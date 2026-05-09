import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    required this.hintText,
    required this.onSaved,
    this.validator,
    this.keyboardType,
    this.prefixAsset,
    this.obscureText = false,
    this.fillColor = AuthColors.input,
    this.borderRadius = 12,
    this.hasBorder = false,
    super.key,
  });

  final String hintText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? prefixAsset;
  final bool obscureText;
  final Color fillColor;
  final double borderRadius;
  final bool hasBorder;

  @override
  State<AuthTextFormField> createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  late bool obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: widget.hasBorder
          ? const BorderSide(color: AuthColors.mutedBorder)
          : BorderSide.none,
    );

    return SizedBox(
      height: 56,
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator ?? _requiredValidator,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        cursorColor: AuthColors.accent,
        style: const TextStyle(
          color: AuthColors.title,
          fontSize: 16,
          height: 1.5,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AuthColors.body,
            fontSize: 16,
            height: 1.5,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: widget.prefixAsset == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 17, right: 8),
                  child: AuthAssetImage(
                    widget.prefixAsset!,
                    width: 18,
                    height: 18,
                  ),
                ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 43,
            minHeight: 56,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() => obscureText = !obscureText);
                  },
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AuthColors.body,
                    size: 22,
                  ),
                )
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AuthColors.accent),
          ),
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }
}

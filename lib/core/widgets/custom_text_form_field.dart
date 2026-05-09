import 'package:flutter/material.dart';
import 'package:test_codex/core/widgets/custom_asset_image.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/utils/validators.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    required this.hintText,
    required this.onSaved,
    this.validator,
    this.keyboardType,
    this.prefixAsset,
    this.obscureText = false,
    this.fillColor = AppColors.input,
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: widget.hasBorder
          ? const BorderSide(color: AppColors.mutedBorder)
          : BorderSide.none,
    );

    return SizedBox(
      height: 56,
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator ?? Validators.requiredField,
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        cursorColor: AppColors.accent,
        style: const TextStyle(
          color: AppColors.title,
          fontSize: 16,
          height: 1.5,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.body,
            fontSize: 16,
            height: 1.5,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: widget.prefixAsset == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 17, right: 8),
                  child: CustomAssetImage(
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
                    color: AppColors.body,
                    size: 22,
                  ),
                )
              : null,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.accent),
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
}

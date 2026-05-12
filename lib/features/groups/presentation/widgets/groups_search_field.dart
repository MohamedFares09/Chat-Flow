import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class GroupsSearchField extends StatelessWidget {
  const GroupsSearchField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    required this.onClear,
    this.isLoading = false,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColors.title, fontSize: 16),
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.body.withValues(alpha: 0.5),
          fontSize: 16,
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.hint, size: 22),
        suffixIcon: isLoading
            ? const Padding(
                padding: EdgeInsets.all(14),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : IconButton(
                onPressed: onClear,
                icon: Icon(Icons.close, color: AppColors.hint, size: 18),
              ),
        filled: true,
        fillColor: AppColors.input.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}

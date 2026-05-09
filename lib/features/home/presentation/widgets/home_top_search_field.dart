import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeTopSearchField extends StatelessWidget {
  const HomeTopSearchField({
    required this.controller,
    required this.isLoading,
    required this.onSearch,
    required this.onClear,
    super.key,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => onSearch(),
      cursorColor: AppColors.accent,
      style: const TextStyle(color: AppColors.title, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.input,
        hintText: 'Search email',
        hintStyle: const TextStyle(color: AppColors.body),
        prefixIcon: const Icon(Icons.search, color: AppColors.body),
        suffixIcon: isLoading
            ? const Padding(
                padding: EdgeInsets.all(14),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onSearch,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.accent,
                    ),
                  ),
                  IconButton(
                    onPressed: onClear,
                    icon: const Icon(Icons.close, color: AppColors.body),
                  ),
                ],
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accent),
        ),
      ),
    );
  }
}

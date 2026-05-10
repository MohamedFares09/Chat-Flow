import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeFab extends StatelessWidget {
  const HomeFab({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 96,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a000000),
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(Icons.add_a_photo_outlined, color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class HomeUserAvatar extends StatelessWidget {
  const HomeUserAvatar({
    required this.name,
    this.size = 56,
    this.showOnlineDot = false,
    this.backgroundColor,
    super.key,
  });

  final String name;
  final double size;
  final bool showOnlineDot;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: backgroundColor == null
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, Color(0xff5203d5)],
                  )
                : null,
            color: backgroundColor,
            border: Border.all(color: AppColors.mutedBorder),
          ),
          child: Center(
            child: Text(
              _initials,
              style: TextStyle(
                color: Colors.white,
                fontSize: size * 0.32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        if (showOnlineDot)
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xff4ade80),
                border: Border.all(color: AppColors.scaffold, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
      ],
    );
  }

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}

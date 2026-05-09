import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    required this.child,
    this.useRegisterColor = false,
    super.key,
  });

  final Widget child;
  final bool useRegisterColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: useRegisterColor
            ? AuthColors.registerScaffold
            : AuthColors.scaffold,
      ),
      child: Stack(
        children: [
          Positioned(
            left: -39,
            top: -88,
            child: _Glow(
              color: AuthColors.primary.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            right: -39,
            bottom: -88,
            child: _Glow(
              color: const Color(0xff5203d5).withValues(alpha: 0.1),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: 195,
        height: 442,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

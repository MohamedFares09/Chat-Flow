import 'package:flutter/material.dart';

class AuthProgressHud extends StatelessWidget {
  const AuthProgressHud({
    required this.isLoading,
    required this.child,
    super.key,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black.withValues(alpha: 0.35),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

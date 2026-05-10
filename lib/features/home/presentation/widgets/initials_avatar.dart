import 'package:flutter/material.dart';

class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    required this.initials,
    required this.fontSize,
    super.key,
  });

  final String initials;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

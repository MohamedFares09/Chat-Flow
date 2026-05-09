import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';

class MessageUserAvatar extends StatelessWidget {
  const MessageUserAvatar({
    required this.name,
    required this.isOnline,
    this.photoUrl,
    super.key,
  });

  final String name;
  final bool isOnline;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final imageUrl = photoUrl?.trim();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.input,
          backgroundImage: imageUrl == null || imageUrl.isEmpty
              ? null
              : NetworkImage(imageUrl),
          child: imageUrl == null || imageUrl.isEmpty
              ? Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : null,
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isOnline ? const Color(0xff22c55e) : AppColors.hint,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.scaffold, width: 2),
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

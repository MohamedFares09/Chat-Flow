import 'package:flutter/material.dart';
import 'package:test_codex/features/home/presentation/widgets/initials_avatar.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({
    required this.name,
    this.photoUrl,
    this.size = 44,
    super.key,
  });

  final String name;
  final String? photoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final imageUrl = photoUrl?.trim();
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xff5203d5),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                imageUrl,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return InitialsAvatar(
                    initials: _initials,
                    fontSize: size * 0.32,
                  );
                },
              )
            : size > 56
            ? InitialsAvatar(initials: _initials, fontSize: size * 0.32)
            : Icon(Icons.groups, color: Colors.white, size: size * 0.52),
      ),
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

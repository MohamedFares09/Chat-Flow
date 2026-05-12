import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_contact_item.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class GroupsContactsList extends StatelessWidget {
  const GroupsContactsList({required this.contacts, super.key});

  final List<HomeUserEntity> contacts;

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Column(
          children: [
            Icon(Icons.groups_outlined, color: AppColors.hint, size: 44),
            const SizedBox(height: 12),
            Text(
              'No contacts yet',
              style: TextStyle(
                color: AppColors.title,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'People you have chatted with will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.body, fontSize: 14),
            ),
          ],
        ),
      );
    }

    final sections = <String, List<HomeUserEntity>>{};
    for (final contact in contacts) {
      final key = contact.name.trim().isEmpty
          ? '#'
          : contact.name.trim().substring(0, 1).toUpperCase();
      sections.putIfAbsent(key, () => []).add(contact);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              color: const Color(0xff191c23).withValues(alpha: 0.3),
              child: Text(
                entry.key,
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            ...entry.value.map((contact) => GroupsContactItem(user: contact)),
            const SizedBox(height: 8),
          ],
        );
      }).toList(),
    );
  }
}

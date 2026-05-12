import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/groups/presentation/cubits/new_group/new_group_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_contact_item.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_search_field.dart';
import 'package:test_codex/features/groups/presentation/widgets/new_group_header.dart';
import 'package:test_codex/features/groups/presentation/widgets/new_group_identity_section.dart';
import 'package:test_codex/features/groups/presentation/widgets/new_group_selected_chips.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class NewGroupViewBody extends StatefulWidget {
  const NewGroupViewBody({
    required this.contacts,
    required this.selectedMembers,
    required this.isSearchLoading,
    super.key,
  });

  final List<HomeUserEntity> contacts;
  final List<HomeUserEntity> selectedMembers;
  final bool isSearchLoading;

  @override
  State<NewGroupViewBody> createState() => _NewGroupViewBodyState();
}

class _NewGroupViewBodyState extends State<NewGroupViewBody> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                NewGroupHeader(onDone: _createGroup),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 96),
                    children: [
                      NewGroupIdentitySection(controller: nameController),
                      const SizedBox(height: 32),
                      _MembersHeader(
                        selectedCount: widget.selectedMembers.length,
                      ),
                      const SizedBox(height: 16),
                      NewGroupSelectedChips(
                        members: widget.selectedMembers,
                        onRemove: (user) =>
                            context.read<NewGroupCubit>().toggleMember(user),
                      ),
                      const SizedBox(height: 16),
                      GroupsSearchField(
                        controller: searchController,
                        hintText: 'Search contacts',
                        isLoading: widget.isSearchLoading,
                        onChanged: (query) =>
                            context.read<NewGroupCubit>().searchContacts(query),
                        onClear: () {
                          searchController.clear();
                          context.read<NewGroupCubit>().searchContacts('');
                        },
                      ),
                      const SizedBox(height: 32),
                      ...widget.contacts.map((contact) {
                        final isSelected = widget.selectedMembers.any(
                          (member) => member.uId == contact.uId,
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: GroupsContactItem(
                            user: contact,
                            isSelected: isSelected,
                            onTap: () => context
                                .read<NewGroupCubit>()
                                .toggleMember(contact),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: _createGroup,
                child: const Icon(Icons.check, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createGroup() {
    context.read<NewGroupCubit>().createGroup(nameController.text);
  }
}

class _MembersHeader extends StatelessWidget {
  const _MembersHeader({required this.selectedCount});

  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Add Members',
          style: TextStyle(
            color: AppColors.title,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
        ),
        const Spacer(),
        Text(
          '$selectedCount SELECTED',
          style: TextStyle(
            color: AppColors.accent,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

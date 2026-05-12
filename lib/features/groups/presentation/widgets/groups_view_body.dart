import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/core/widgets/app_bottom_nav_bar.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/presentation/cubits/groups/groups_cubit.dart';
import 'package:test_codex/features/groups/presentation/views/group_chat_view.dart';
import 'package:test_codex/features/groups/presentation/views/new_group_view.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_contacts_list.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_header.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_quick_actions.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_search_field.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_summary_list.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class GroupsViewBody extends StatefulWidget {
  const GroupsViewBody({
    required this.groups,
    required this.contacts,
    required this.isSearchLoading,
    super.key,
  });

  final List<GroupEntity> groups;
  final List<HomeUserEntity> contacts;
  final bool isSearchLoading;

  @override
  State<GroupsViewBody> createState() => _GroupsViewBodyState();
}

class _GroupsViewBodyState extends State<GroupsViewBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
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
                const GroupsHeader(),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () => context.read<GroupsCubit>().getContacts(),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      children: [
                        GroupsSearchField(
                          controller: searchController,
                          hintText: 'Search contacts...',
                          isLoading: widget.isSearchLoading,
                          onChanged: _search,
                          onClear: _clearSearch,
                        ),
                        const SizedBox(height: 24),
                        GroupsQuickActions(
                          onNewContact: () {},
                          onNewGroup: _openNewGroup,
                        ),
                        if (widget.groups.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          GroupsSummaryList(
                            groups: widget.groups,
                            onGroupTap: _openGroupChat,
                          ),
                        ],
                        const SizedBox(height: 24),
                        GroupsContactsList(contacts: widget.contacts),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 24,
              bottom: 96,
              child: FloatingActionButton(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: _openNewGroup,
                child: const Icon(Icons.group_add, color: Colors.white),
              ),
            ),
            AppBottomNavBar(
              selectedIndex: 1,
              onItemSelected: (index) {
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, RouteNames.home);
                } else if (index == 3) {
                  Navigator.pushReplacementNamed(context, RouteNames.settings);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _search(String query) {
    context.read<GroupsCubit>().searchContacts(query);
  }

  void _clearSearch() {
    searchController.clear();
    context.read<GroupsCubit>().clearSearch();
  }

  void _openNewGroup() {
    Navigator.pushNamed(context, NewGroupView.route);
  }

  void _openGroupChat(GroupEntity group) {
    Navigator.pushNamed(context, GroupChatView.route, arguments: group);
  }
}

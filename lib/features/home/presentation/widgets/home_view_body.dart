import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:test_codex/features/home/presentation/widgets/home_bottom_nav_bar.dart';
import 'package:test_codex/features/home/presentation/widgets/home_chat_list.dart';
import 'package:test_codex/features/home/presentation/widgets/home_fab.dart';
import 'package:test_codex/features/home/presentation/widgets/home_header.dart';
import 'package:test_codex/features/home/presentation/widgets/home_search_results.dart';
import 'package:test_codex/features/home/presentation/widgets/home_stories_section.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    required this.conversations,
    required this.searchResults,
    required this.isSearchLoading,
    super.key,
  });

  final List<ConversationEntity> conversations;
  final List<HomeUserEntity> searchResults;
  final bool isSearchLoading;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      useRegisterColor: true,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                HomeHeader(
                  searchController: searchController,
                  isSearchLoading: widget.isSearchLoading,
                  onSearch: _search,
                  onClearSearch: _clearSearch,
                ),
                Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: () => context.read<HomeCubit>().getConversations(),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                      children: [
                        const HomeStoriesSection(),
                        if (widget.searchResults.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          HomeSearchResults(
                            users: widget.searchResults,
                            onStartConversation: (user) {
                              context
                                  .read<HomeCubit>()
                                  .createConversationWithUser(user);
                              searchController.clear();
                            },
                          ),
                        ],
                        const SizedBox(height: 24),
                        HomeChatList(conversations: widget.conversations),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const HomeFab(),
            const HomeBottomNavBar(),
          ],
        ),
      ),
    );
  }

  void _search() {
    final email = searchController.text.trim();
    if (email.isEmpty) {
      context.read<HomeCubit>().clearSearch();
      return;
    }
    context.read<HomeCubit>().searchUsersByEmail(email);
  }

  void _clearSearch() {
    searchController.clear();
    context.read<HomeCubit>().clearSearch();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/core/widgets/app_background.dart';
import 'package:test_codex/core/widgets/app_bottom_nav_bar.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_story_entity.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:test_codex/features/home/presentation/widgets/add_story_sheet.dart';
import 'package:test_codex/features/home/presentation/widgets/home_chat_list.dart';
import 'package:test_codex/features/home/presentation/widgets/home_fab.dart';
import 'package:test_codex/features/home/presentation/widgets/home_header.dart';
import 'package:test_codex/features/home/presentation/widgets/home_search_results.dart';
import 'package:test_codex/features/home/presentation/widgets/home_stories_section.dart';
import 'package:test_codex/features/home/presentation/widgets/story_viewer_dialog.dart';
import 'package:test_codex/features/message/presentation/views/message_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    required this.conversations,
    required this.stories,
    required this.searchResults,
    required this.isSearchLoading,
    required this.isStoryActionLoading,
    super.key,
  });

  final List<ConversationEntity> conversations;
  final List<HomeStoryEntity> stories;
  final List<HomeUserEntity> searchResults;
  final bool isSearchLoading;
  final bool isStoryActionLoading;

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
                        HomeStoriesSection(
                          stories: widget.stories,
                          isAddingStory: widget.isStoryActionLoading,
                          onAddStory: _showAddStorySheet,
                          onStoryTap: _showStoryViewer,
                        ),
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
                        HomeChatList(
                          conversations: widget.conversations,
                          onConversationTap: (conversation) {
                            Navigator.pushNamed(
                              context,
                              MessageView.route,
                              arguments: conversation,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            HomeFab(onPressed: _showAddStorySheet),
            AppBottomNavBar(
              selectedIndex: 0,
              onItemSelected: (index) {
                if (index == 3) {
                  Navigator.pushReplacementNamed(context, RouteNames.settings);
                }
              },
            ),
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

  Future<void> _showAddStorySheet() async {
    final result = await showModalBottomSheet<StoryUploadResult>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddStorySheet(),
    );
    if (result == null || !mounted) {
      return;
    }
    switch (result.type) {
      case StoryUploadType.text:
        context.read<HomeCubit>().addStory(result.content);
      case StoryUploadType.image:
        final filePath = result.filePath;
        if (filePath == null) {
          return;
        }
        context.read<HomeCubit>().addMediaStory(
              filePath: filePath,
              type: 'image',
              content: result.content,
            );
      case StoryUploadType.video:
        final filePath = result.filePath;
        if (filePath == null) {
          return;
        }
        context.read<HomeCubit>().addMediaStory(
              filePath: filePath,
              type: 'video',
              content: result.content,
            );
    }
  }

  void _showStoryViewer(HomeStoryEntity story) {
    context.read<HomeCubit>().markStoryAsSeen(story);
    showDialog<void>(
      context: context,
      builder: (context) => StoryViewerDialog(story: story),
    );
  }
}

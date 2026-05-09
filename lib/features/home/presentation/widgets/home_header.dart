import 'package:flutter/material.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/features/home/presentation/widgets/home_top_search_field.dart';
import 'package:test_codex/features/home/presentation/widgets/home_user_avatar.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    required this.searchController,
    required this.isSearchLoading,
    required this.onSearch,
    required this.onClearSearch,
    super.key,
  });

  final TextEditingController searchController;
  final bool isSearchLoading;
  final VoidCallback onSearch;
  final VoidCallback onClearSearch;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.scaffold.withValues(alpha: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!isSearching) ...[
            const HomeUserAvatar(name: 'You', size: 40, showOnlineDot: true),
            const Spacer(),
            const Text(
              'ChatFlow',
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() => isSearching = true);
              },
              icon: const Icon(Icons.search, color: AppColors.body, size: 22),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.more_vert, color: AppColors.body, size: 22),
          ] else ...[
            Expanded(
              child: HomeTopSearchField(
                controller: widget.searchController,
                isLoading: widget.isSearchLoading,
                onSearch: widget.onSearch,
                onClear: () {
                  widget.onClearSearch();
                  setState(() => isSearching = false);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

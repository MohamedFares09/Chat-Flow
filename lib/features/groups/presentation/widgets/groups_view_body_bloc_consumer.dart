import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/groups/presentation/cubits/groups/groups_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_view_body.dart';

class GroupsViewBodyBlocConsumer extends StatelessWidget {
  const GroupsViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupsCubit, GroupsState>(
      listener: (context, state) {
        if (state is GroupsErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<GroupsCubit>();
        return CustomProgressHud(
          isLoading: state is GroupsLoadingState,
          child: GroupsViewBody(
            groups: cubit.groups,
            contacts: cubit.searchResults.isEmpty
                ? cubit.contacts
                : cubit.searchResults,
            isSearchLoading: state is GroupsSearchLoadingState,
          ),
        );
      },
    );
  }
}

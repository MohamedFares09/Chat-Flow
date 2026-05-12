import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/groups/presentation/cubits/new_group/new_group_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/new_group_view_body.dart';

class NewGroupViewBodyBlocConsumer extends StatelessWidget {
  const NewGroupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewGroupCubit, NewGroupState>(
      listener: (context, state) {
        if (state is NewGroupErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        } else if (state is NewGroupCreateSuccessState) {
          buildSnackBar(
            context,
            message: 'Group created successfully.',
            color: Colors.green,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final cubit = context.read<NewGroupCubit>();
        return CustomProgressHud(
          isLoading:
              state is NewGroupLoadingState ||
              state is NewGroupCreateLoadingState,
          child: NewGroupViewBody(
            contacts: cubit.visibleContacts,
            selectedMembers: cubit.selectedMembers,
            isSearchLoading: state is NewGroupSearchLoadingState,
          ),
        );
      },
    );
  }
}

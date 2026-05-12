import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_details/group_details_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_details_view_body.dart';

class GroupDetailsViewBodyBlocConsumer extends StatelessWidget {
  const GroupDetailsViewBodyBlocConsumer({required this.group, super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupDetailsCubit, GroupDetailsState>(
      listener: (context, state) {
        if (state is GroupDetailsErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        } else if (state is GroupDetailsUpdateSuccessState) {
          buildSnackBar(
            context,
            message: 'Group updated successfully.',
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<GroupDetailsCubit>();
        return CustomProgressHud(
          isLoading: state is GroupDetailsUpdateLoadingState,
          child: GroupDetailsViewBody(group: cubit.group ?? group),
        );
      },
    );
  }
}

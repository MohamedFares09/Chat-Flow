import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_chat/group_chat_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_chat_view_body.dart';

class GroupChatViewBodyBlocConsumer extends StatelessWidget {
  const GroupChatViewBodyBlocConsumer({required this.group, super.key});

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupChatCubit, GroupChatState>(
      listener: (context, state) {
        if (state is GroupChatErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<GroupChatCubit>();
        return CustomProgressHud(
          isLoading: state is GroupChatLoadingState,
          child: GroupChatViewBody(
            group: cubit.activeGroup ?? group,
            messages: cubit.messages,
            isSending: state is GroupChatSendLoadingState,
          ),
        );
      },
    );
  }
}

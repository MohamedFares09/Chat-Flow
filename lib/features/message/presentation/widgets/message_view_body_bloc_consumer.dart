import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_cubit.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_state.dart';
import 'package:test_codex/features/message/presentation/widgets/message_view_body.dart';

class MessageViewBodyBlocConsumer extends StatelessWidget {
  const MessageViewBodyBlocConsumer({required this.conversation, super.key});

  final ConversationEntity conversation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MessageCubit, MessageState>(
      listener: (context, state) {
        if (state is MessageErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<MessageCubit>();
        final activeConversation = cubit.activeConversation ?? conversation;
        return CustomProgressHud(
          isLoading: state is MessageLoadingState,
          child: MessageViewBody(
            conversation: activeConversation,
            messages: cubit.messages,
            isSending: state is MessageSendLoadingState,
          ),
        );
      },
    );
  }
}

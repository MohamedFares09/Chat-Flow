import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/features/home/domain/entities/conversation_entity.dart';
import 'package:test_codex/features/message/domain/repos/message_repo.dart';
import 'package:test_codex/features/message/presentation/cubits/message/message_cubit.dart';
import 'package:test_codex/features/message/presentation/widgets/message_view_body_bloc_consumer.dart';

class MessageView extends StatelessWidget {
  const MessageView({
    required this.conversation,
    super.key,
  });

  static const String route = RouteNames.message;

  final ConversationEntity conversation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit(getIt<MessageRepo>())
        ..getMessages(conversation.id),
      child: Scaffold(
        body: MessageViewBodyBlocConsumer(conversation: conversation),
      ),
    );
  }
}

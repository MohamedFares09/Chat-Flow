import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_chat/group_chat_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_chat_view_body_bloc_consumer.dart';

class GroupChatView extends StatelessWidget {
  const GroupChatView({required this.group, super.key});

  static const String route = RouteNames.groupChat;

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupChatCubit(getIt<GroupsRepo>())..openGroup(group),
      child: Scaffold(body: GroupChatViewBodyBlocConsumer(group: group)),
    );
  }
}

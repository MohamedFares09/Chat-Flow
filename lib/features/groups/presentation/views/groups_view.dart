import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/groups/presentation/cubits/groups/groups_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/groups_view_body_bloc_consumer.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

  static const String route = RouteNames.groups;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsCubit(getIt<GroupsRepo>())..watchGroups(),
      child: const Scaffold(body: GroupsViewBodyBlocConsumer()),
    );
  }
}

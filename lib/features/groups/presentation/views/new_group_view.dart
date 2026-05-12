import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/groups/presentation/cubits/new_group/new_group_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/new_group_view_body_bloc_consumer.dart';

class NewGroupView extends StatelessWidget {
  const NewGroupView({super.key});

  static const String route = RouteNames.newGroup;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewGroupCubit(getIt<GroupsRepo>())..getContacts(),
      child: const Scaffold(body: NewGroupViewBodyBlocConsumer()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/route_names.dart';
import 'package:test_codex/features/groups/domain/entities/group_entity.dart';
import 'package:test_codex/features/groups/domain/repos/groups_repo.dart';
import 'package:test_codex/features/groups/presentation/cubits/group_details/group_details_cubit.dart';
import 'package:test_codex/features/groups/presentation/widgets/group_details_view_body_bloc_consumer.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({required this.group, super.key});

  static const String route = RouteNames.groupDetails;

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupDetailsCubit(getIt<GroupsRepo>())..watchGroup(group),
      child: Scaffold(body: GroupDetailsViewBodyBlocConsumer(group: group)),
    );
  }
}

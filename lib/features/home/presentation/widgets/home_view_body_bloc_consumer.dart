import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/message/presentation/views/message_view.dart';
import 'package:test_codex/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:test_codex/features/home/presentation/widgets/home_view_body.dart';

class HomeViewBodyBlocConsumer extends StatelessWidget {
  const HomeViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        } else if (state is HomeConversationCreatedState) {
          Navigator.pushNamed(
            context,
            MessageView.route,
            arguments: state.conversation,
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        return CustomProgressHud(
          isLoading: state is HomeLoadingState || state is HomeActionLoadingState,
          child: HomeViewBody(
            conversations: cubit.conversations,
            stories: cubit.stories,
            searchResults: cubit.searchResults,
            isSearchLoading: state is HomeSearchLoadingState,
            isStoryActionLoading: state is HomeStoryActionLoadingState,
          ),
        );
      },
    );
  }
}

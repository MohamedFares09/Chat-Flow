import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_view_body.dart';

class RegisterViewBodyBlocConsumer extends StatelessWidget {
  const RegisterViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          showAppSnackBar(
            context,
            message: state.message,
            backgroundColor: Colors.red,
          );
        } else if (state is RegisterSuccessState) {
          showAppSnackBar(
            context,
            message: 'Account created successfully',
            backgroundColor: Colors.green,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is RegisterLoadingState,
          child: const RegisterViewBody(),
        );
      },
    );
  }
}

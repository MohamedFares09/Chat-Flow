import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/utils/app_snack_bar.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showAppSnackBar(
            context,
            message: state.message,
            backgroundColor: Colors.red,
          );
        } else if (state is LoginSuccessState) {
          showAppSnackBar(
            context,
            message: 'Logged in successfully',
            backgroundColor: Colors.green,
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHUD(
          isLoading: state is LoginLoadingState,
          child: const LoginViewBody(),
        );
      },
    );
  }
}

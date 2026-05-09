import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_progress_hud.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_view_body.dart';

class LoginViewBodyBlocConsumer extends StatelessWidget {
  const LoginViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showAuthSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        } else if (state is LoginSuccessState) {
          showAuthSnackBar(
            context,
            message: 'Signed in successfully.',
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        return AuthProgressHud(
          isLoading: state is LoginLoadingState,
          child: const LoginViewBody(),
        );
      },
    );
  }
}

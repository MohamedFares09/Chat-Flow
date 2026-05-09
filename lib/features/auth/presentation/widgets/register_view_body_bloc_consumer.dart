import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:test_codex/features/auth/presentation/views/login_view.dart';
import 'package:test_codex/core/widgets/custom_progress_hud.dart';
import 'package:test_codex/core/widgets/build_snack_bar.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_view_body.dart';

class RegisterViewBodyBlocConsumer extends StatelessWidget {
  const RegisterViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterErrorState) {
          buildSnackBar(
            context,
            message: state.message,
            color: Colors.redAccent,
          );
        } else if (state is RegisterSuccessState) {
          buildSnackBar(
            context,
            message: 'Account created successfully.',
            color: Colors.green,
          );
          Navigator.pushReplacementNamed(context, LoginView.route);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is RegisterLoadingState,
          child: const RegisterViewBody(),
        );
      },
    );
  }
}

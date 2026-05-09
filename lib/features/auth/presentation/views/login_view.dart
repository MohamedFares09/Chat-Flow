import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';
import 'package:test_codex/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_view_body_bloc_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        body: LoginViewBodyBlocConsumer(),
      ),
    );
  }
}

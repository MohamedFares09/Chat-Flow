import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';
import 'package:test_codex/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_view_body_bloc_consumer.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String route = '/register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        body: RegisterViewBodyBlocConsumer(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:test_codex/features/auth/presentation/views/register_view.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_background.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_card.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_footer.dart';
import 'package:test_codex/features/auth/presentation/widgets/login_header.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late String email;
  late String password;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  const LoginHeader(),
                  const SizedBox(height: 32),
                  LoginCard(
                    formKey: formKey,
                    autovalidateMode: autovalidateMode,
                    onEmailSaved: (value) => email = value!.trim(),
                    onPasswordSaved: (value) => password = value!,
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: 32),
                  LoginFooter(
                    onRegisterTap: () {
                      Navigator.pushNamed(context, RegisterView.route);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<LoginCubit>().signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }
}

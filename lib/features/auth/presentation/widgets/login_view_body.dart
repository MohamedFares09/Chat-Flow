import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:test_codex/features/auth/presentation/views/register_view.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_background.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_button.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_text_form_field.dart';

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
                  const _LoginHeader(),
                  const SizedBox(height: 32),
                  _LoginCard(
                    formKey: formKey,
                    autovalidateMode: autovalidateMode,
                    onEmailSaved: (value) => email = value!.trim(),
                    onPasswordSaved: (value) => password = value!,
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: 32),
                  _LoginFooter(
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

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AuthColors.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1a000000),
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Center(
            child: const AuthAssetImage(
              AuthAssets.chatIcon,
              width: 34,
              height: 34,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'ChatFlow',
          style: TextStyle(
            color: AuthColors.title,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Securely connect with your team and\nfriends across the globe.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AuthColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _LoginCard extends StatelessWidget {
  const _LoginCard({
    required this.formKey,
    required this.autovalidateMode,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final FormFieldSetter<String> onEmailSaved;
  final FormFieldSetter<String> onPasswordSaved;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(33),
      decoration: BoxDecoration(
        color: AuthColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuthColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 50,
            offset: Offset(0, 25),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children: [
            AuthTextFormField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              onSaved: onEmailSaved,
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            AuthTextFormField(
              hintText: 'Password',
              obscureText: true,
              onSaved: onPasswordSaved,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showAuthSnackBar(
                    context,
                    message: 'Password reset will be added soon.',
                    color: AuthColors.primary,
                  );
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: AuthColors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            AuthButton(text: 'Sign In', onPressed: onSubmit),
            const SizedBox(height: 16),
            const _DividerText(),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                showAuthSnackBar(
                  context,
                  message: 'Google sign in needs google_sign_in setup.',
                  color: AuthColors.primary,
                );
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromHeight(56),
                side: const BorderSide(color: AuthColors.mutedBorder),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AuthAssetImage(
                    AuthAssets.google,
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: AuthColors.title,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
}

class _DividerText extends StatelessWidget {
  const _DividerText();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0x4d414754))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(
              color: AuthColors.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(child: Divider(color: Color(0x4d414754))),
      ],
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter({required this.onRegisterTap});

  final VoidCallback onRegisterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            color: AuthColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        GestureDetector(
          onTap: onRegisterTap,
          child: const Text(
            'Register',
            style: TextStyle(
              color: AuthColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

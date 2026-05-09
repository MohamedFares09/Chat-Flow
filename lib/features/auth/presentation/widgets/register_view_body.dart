import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/features/auth/presentation/cubits/register/register_cubit.dart';
import 'package:test_codex/features/auth/presentation/views/login_view.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_asset_image.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_assets.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_background.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_button.dart';
import 'package:test_codex/features/auth/presentation/widgets/auth_colors.dart';
import 'package:test_codex/features/auth/presentation/widgets/register_labeled_field.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  bool agreedToTerms = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      useRegisterColor: true,
      child: SafeArea(
        child: Column(
          children: [
            const _RegisterTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _RegisterHeader(),
                    const SizedBox(height: 32),
                    _RegisterCard(
                      formKey: formKey,
                      autovalidateMode: autovalidateMode,
                      agreedToTerms: agreedToTerms,
                      onTermsChanged: (value) {
                        setState(() => agreedToTerms = value ?? false);
                      },
                      onNameSaved: (value) => name = value!.trim(),
                      onEmailSaved: (value) => email = value!.trim(),
                      onPasswordSaved: (value) => password = value!,
                      onConfirmSaved: (value) => confirmPassword = value!,
                      onSubmit: _submit,
                    ),
                    const SizedBox(height: 32),
                    const _RegisterFooter(),
                    const SizedBox(height: 48),
                    const _FooterGraphics(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!agreedToTerms) {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
      return;
    }
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (password != confirmPassword) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Passwords do not match.'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        return;
      }
      context.read<RegisterCubit>().createUserWithEmailAndPassword(
            name: name,
            email: email,
            password: password,
          );
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState(() {});
    }
  }

}

class _RegisterTopBar extends StatelessWidget {
  const _RegisterTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AuthColors.scaffold.withValues(alpha: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0d000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const AuthAssetImage(
              AuthAssets.backIcon,
              width: 16,
              height: 16,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'ChatFlow',
            style: TextStyle(
              color: AuthColors.accent,
              fontSize: 32,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
          const Spacer(),
          const AuthAssetImage(AuthAssets.infoIcon, width: 20, height: 20),
        ],
      ),
    );
  }
}

class _RegisterHeader extends StatelessWidget {
  const _RegisterHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join the Flow',
          style: TextStyle(
            color: AuthColors.accent,
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Create your account to start seamless\nconversations with your world.',
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

class _RegisterCard extends StatelessWidget {
  const _RegisterCard({
    required this.formKey,
    required this.autovalidateMode,
    required this.agreedToTerms,
    required this.onTermsChanged,
    required this.onNameSaved,
    required this.onEmailSaved,
    required this.onPasswordSaved,
    required this.onConfirmSaved,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final bool agreedToTerms;
  final ValueChanged<bool?> onTermsChanged;
  final FormFieldSetter<String> onNameSaved;
  final FormFieldSetter<String> onEmailSaved;
  final FormFieldSetter<String> onPasswordSaved;
  final FormFieldSetter<String> onConfirmSaved;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 34),
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
            const _AvatarUpload(),
            const SizedBox(height: 32),
            RegisterLabeledField(
              label: 'FULL NAME',
              hintText: 'Alex Rivers',
              prefixAsset: AuthAssets.userIcon,
              onSaved: onNameSaved,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'EMAIL ADDRESS',
              hintText: 'alex@chatflow.io',
              prefixAsset: AuthAssets.emailIcon,
              keyboardType: TextInputType.emailAddress,
              onSaved: onEmailSaved,
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'PASSWORD',
              hintText: 'Password',
              prefixAsset: AuthAssets.lockIcon,
              obscureText: true,
              onSaved: onPasswordSaved,
              validator: _passwordValidator,
            ),
            const SizedBox(height: 16),
            RegisterLabeledField(
              label: 'CONFIRM PASSWORD',
              hintText: 'Confirm password',
              prefixAsset: AuthAssets.shieldIcon,
              obscureText: true,
              onSaved: onConfirmSaved,
              validator: _passwordValidator,
            ),
            const SizedBox(height: 24),
            _TermsRow(
              agreedToTerms: agreedToTerms,
              onChanged: onTermsChanged,
            ),
            const SizedBox(height: 24),
            AuthButton(
              text: 'Create Account',
              borderRadius: 16,
              onPressed: onSubmit,
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

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }
}

class _AvatarUpload extends StatelessWidget {
  const _AvatarUpload();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 96,
              height: 96,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AuthColors.input,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: const Color(0xff414754),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: ClipOval(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: const AuthAssetImage(
                        AuthAssets.profilePlaceholder,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ColoredBox(
                      color: AuthColors.scaffold.withValues(alpha: 0.4),
                    ),
                    Center(
                      child: const AuthAssetImage(
                        AuthAssets.cameraIcon,
                        width: 25,
                        height: 23,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: const AuthAssetImage(
                AuthAssets.avatarAdd,
                width: 45,
                height: 53,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'UPLOAD PHOTO',
          style: TextStyle(
            color: AuthColors.body,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            height: 1.33,
          ),
        ),
      ],
    );
  }
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({
    required this.agreedToTerms,
    required this.onChanged,
  });

  final bool agreedToTerms;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          height: 24,
          child: Checkbox(
            value: agreedToTerms,
            onChanged: onChanged,
            side: const BorderSide(color: Color(0xff414754)),
            activeColor: AuthColors.primary,
            checkColor: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: AuthColors.body,
                fontSize: 14,
                height: 1.43,
              ),
              children: [
                const TextSpan(text: 'By signing up, you agree to our '),
                _linkSpan('Terms of\nService'),
                const TextSpan(text: ' and '),
                _linkSpan('Privacy Policy'),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextSpan _linkSpan(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(
        color: AuthColors.accent,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
        decorationColor: Color(0x4dadc7ff),
      ),
    );
  }
}

class _RegisterFooter extends StatelessWidget {
  const _RegisterFooter();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(
            color: AuthColors.body,
            fontSize: 16,
            height: 1.5,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, LoginView.route),
          child: const Text(
            'Log In',
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

class _FooterGraphics extends StatelessWidget {
  const _FooterGraphics();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AuthAssetImage(AuthAssets.footerCloud, width: 59, height: 43),
          const SizedBox(width: 24),
          const AuthAssetImage(AuthAssets.footerRocket, width: 40, height: 40),
          const SizedBox(width: 24),
          const AuthAssetImage(AuthAssets.footerStars, width: 59, height: 59),
        ],
      ),
    );
  }
}

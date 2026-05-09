import 'package:flutter/material.dart';
import 'package:test_codex/features/auth/presentation/views/login_view.dart';
import 'package:test_codex/features/auth/presentation/views/register_view.dart';
import 'package:test_codex/features/auth/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.route:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case LoginView.route:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case RegisterView.route:
      return MaterialPageRoute(builder: (_) => const RegisterView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}

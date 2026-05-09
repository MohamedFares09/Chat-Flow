import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_codex/core/services/service_locator.dart';
import 'package:test_codex/features/auth/presentation/views/login_view.dart';
import 'package:test_codex/features/auth/presentation/views/register_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setupServiceLocator();
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: LoginView.route,
      routes: {
        LoginView.route: (context) => const LoginView(),
        RegisterView.route: (context) => const RegisterView(),
      },
    );
  }
}

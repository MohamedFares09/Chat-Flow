import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/app_routes.dart';
import 'package:test_codex/features/auth/presentation/views/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.route,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Hanken Grotesk',
        scaffoldBackgroundColor: const Color(0xff10131a),
      ),
    );
  }
}

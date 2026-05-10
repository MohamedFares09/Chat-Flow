import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_codex/core/cubits/theme/theme_cubit.dart';
import 'package:test_codex/core/services/get_it_service.dart';
import 'package:test_codex/core/utils/app_colors.dart';
import 'package:test_codex/core/utils/app_routes.dart';
import 'package:test_codex/core/utils/app_theme.dart';
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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          AppColors.setIsDark(state.isDark);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: SplashView.route,
            onGenerateRoute: onGenerateRoute,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }
}

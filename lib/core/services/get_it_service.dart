import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:test_codex/features/auth/data/repos/auth_repo_impl.dart';
import 'package:test_codex/features/auth/data/services/firebase_auth_service.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  if (getIt.isRegistered<AuthRepo>()) {
    return;
  }

  getIt.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(FirebaseAuth.instance),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authService: getIt<FirebaseAuthService>()),
  );
}

import 'package:get_it/get_it.dart';
import 'package:test_codex/features/auth/data/repos/auth_repo_impl.dart';
import 'package:test_codex/features/auth/data/services/firebase_auth_service.dart';
import 'package:test_codex/features/auth/domain/repos/auth_repo.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  if (!getIt.isRegistered<FirebaseAuthService>()) {
    getIt.registerLazySingleton<FirebaseAuthService>(
      FirebaseAuthService.new,
    );
  }

  if (!getIt.isRegistered<AuthRepo>()) {
    getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(firebaseAuthService: getIt<FirebaseAuthService>()),
    );
  }
}

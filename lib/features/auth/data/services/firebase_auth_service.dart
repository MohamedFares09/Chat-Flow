import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';

class FirebaseAuthService {
  FirebaseAuthService(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(_firebaseAuthMessage(e));
    } catch (_) {
      throw CustomException('Something went wrong. Please try again.');
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload();
      return firebaseAuth.currentUser ?? credential.user!;
    } on FirebaseAuthException catch (e) {
      throw CustomException(_firebaseAuthMessage(e));
    } catch (_) {
      throw CustomException('Something went wrong. Please try again.');
    }
  }

  String _firebaseAuthMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Email or password is incorrect.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      default:
        return exception.message ?? 'Authentication failed. Please try again.';
    }
  }
}

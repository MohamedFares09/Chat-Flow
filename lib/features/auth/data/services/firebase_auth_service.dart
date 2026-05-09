import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/error/custom_exception.dart';

part 'firebase_auth_error_mapper.dart';

class FirebaseAuthService {
  FirebaseAuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth? _firebaseAuth;

  // FirebaseAuth get _auth => _firebaseAuth ?? FirebaseAuth.instance;
  final user = FirebaseAuth.instance;

  Future<User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authenticate(
      () => user.signInWithEmailAndPassword(email: email, password: password),
      emptyUserMessage: 'Unable to login. Please try again.',
    );
  }

  Future<User> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _authenticate(
      () => user.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
      emptyUserMessage: 'Unable to create account. Please try again.',
    );
  }

  Future<User> _authenticate(
    Future<UserCredential> Function() request, {
    required String emptyUserMessage,
  }) async {
    try {
      final user = (await request()).user;
      if (user == null) {
        throw CustomException(emptyUserMessage);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw CustomException(_mapFirebaseAuthException(e));
    }
  }
}

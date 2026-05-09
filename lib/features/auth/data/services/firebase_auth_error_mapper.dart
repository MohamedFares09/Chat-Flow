part of 'firebase_auth_service.dart';

String _mapFirebaseAuthException(FirebaseAuthException exception) {
  const messages = {
    'invalid-email': 'Please enter a valid email address.',
    'user-disabled': 'This account has been disabled.',
    'user-not-found': 'Invalid email or password.',
    'wrong-password': 'Invalid email or password.',
    'invalid-credential': 'Invalid email or password.',
    'email-already-in-use': 'This email is already in use.',
    'operation-not-allowed': 'Email/password auth is not enabled.',
    'weak-password': 'Password is too weak.',
    'network-request-failed': 'Network error. Please check your connection.',
  };

  return messages[exception.code] ??
      exception.message ??
      'Authentication failed. Please try again.';
}

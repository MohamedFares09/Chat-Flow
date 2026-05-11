import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ThemeService {
  ThemeService({
    required this.firebaseAuth,
    required this.firestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Stream<User?> authStateChanges() {
    return firebaseAuth.authStateChanges();
  }

  Future<bool?> getSavedTheme() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }

    final doc = await firestore.collection('users').doc(user.uid).get();
    final isDarkTheme = doc.data()?['isDarkTheme'];
    return isDarkTheme is bool ? isDarkTheme : null;
  }

  Future<void> saveTheme({required bool isDark}) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return;
    }

    await firestore.collection('users').doc(user.uid).set(
      {'isDarkTheme': isDark},
      SetOptions(merge: true),
    );
  }
}

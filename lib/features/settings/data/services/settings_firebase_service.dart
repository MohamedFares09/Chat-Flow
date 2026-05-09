import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/settings/data/models/settings_user_model.dart';

class SettingsFirebaseService {
  SettingsFirebaseService({
    required this.firebaseAuth,
    required this.firestore,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Future<SettingsUserModel> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('Please sign in again.');
    }

    final userDoc = await firestore.collection('users').doc(user.uid).get();
    final userData = userDoc.data();
    if (userData == null) {
      return SettingsUserModel.fromFirebaseUser(user);
    }

    return SettingsUserModel.fromJson(
      json: userData,
      fallbackUser: user,
    );
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}

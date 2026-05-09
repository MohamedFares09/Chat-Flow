import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uId,
    required super.email,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uId: user.uid,
      email: user.email ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] ?? '',
      email: json['email'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity user) {
    return UserModel(
      uId: user.uId,
      email: user.email,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
    };
  }
}

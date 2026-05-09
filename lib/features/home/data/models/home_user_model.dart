import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class HomeUserModel extends HomeUserEntity {
  const HomeUserModel({
    required super.uId,
    required super.name,
    required super.email,
    super.photoUrl,
  });

  factory HomeUserModel.fromJson(Map<String, dynamic> json) {
    return HomeUserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'],
    );
  }

  factory HomeUserModel.fromEntity(HomeUserEntity user) {
    return HomeUserModel(
      uId: user.uId,
      name: user.name,
      email: user.email,
      photoUrl: user.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}

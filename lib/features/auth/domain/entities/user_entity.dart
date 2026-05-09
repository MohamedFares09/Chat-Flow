class UserEntity {
  const UserEntity({
    required this.uId,
    required this.email,
  });

  final String uId;
  final String email;

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
    };
  }
}

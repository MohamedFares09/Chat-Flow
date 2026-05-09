class UserEntity {
  const UserEntity({
    required this.uId,
    required this.email,
    required this.name,
  });

  final String uId;
  final String email;
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name,
    };
  }
}

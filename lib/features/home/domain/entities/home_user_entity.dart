class HomeUserEntity {
  const HomeUserEntity({
    required this.uId,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  final String uId;
  final String name;
  final String email;
  final String? photoUrl;
}

class HomeStoryEntity {
  const HomeStoryEntity({
    required this.id,
    required this.uId,
    required this.userName,
    required this.content,
    required this.createdAt,
    this.isMine = false,
    this.isSeen = false,
    this.mediaUrl,
    this.type = 'text',
    this.photoUrl,
  });

  final String id;
  final String uId;
  final String userName;
  final String content;
  final DateTime createdAt;
  final bool isMine;
  final bool isSeen;
  final String? mediaUrl;
  final String type;
  final String? photoUrl;

  bool get isImage => type.toLowerCase() == 'image';

  bool get isVideo => type.toLowerCase() == 'video';
}

class MessageEntity {
  const MessageEntity({
    required this.id,
    required this.text,
    required this.senderId,
    required this.createdAt,
    required this.isMine,
  });

  final String id;
  final String text;
  final String senderId;
  final DateTime createdAt;
  final bool isMine;
}

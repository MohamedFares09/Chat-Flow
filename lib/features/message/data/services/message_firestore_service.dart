import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/home/data/models/conversation_model.dart';
import 'package:test_codex/features/message/data/models/message_model.dart';

class MessageFirestoreService {
  MessageFirestoreService({
    required this.firestore,
    required this.firebaseAuth,
  });

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  Stream<ConversationModel> watchConversation(String conversationId) {
    final currentUserId = _currentUserId;
    return firestore
        .collection('conversations')
        .doc(conversationId)
        .snapshots()
        .map(
          (doc) => ConversationModel.fromFirestore(
            id: doc.id,
            currentUserId: currentUserId,
            json: doc.data() ?? {},
          ),
        );
  }

  Stream<List<MessageModel>> getMessages(String conversationId) {
    final currentUserId = _currentUserId;
    return firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => MessageModel.fromFirestore(
                  id: doc.id,
                  currentUserId: currentUserId,
                  json: doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> sendMessage({
    required String conversationId,
    required String receiverId,
    required String text,
  }) async {
    final currentUserId = _currentUserId;
    final messageText = text.trim();
    if (messageText.isEmpty) {
      throw CustomException('Please write a message first.');
    }

    final conversationRef = firestore.collection('conversations').doc(
          conversationId,
        );
    final messageRef = conversationRef.collection('messages').doc();

    await firestore.runTransaction((transaction) async {
      final conversationSnapshot = await transaction.get(conversationRef);
      final conversationData = conversationSnapshot.data() ?? {};
      final onlineUsers = List<String>.from(
        conversationData['onlineUsers'] ?? [],
      );
      final receiverIsOnline = onlineUsers.contains(receiverId);

      transaction.set(messageRef, {
        'text': messageText,
        'senderId': currentUserId,
        'receiverId': receiverId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(
        conversationRef,
        {
          'lastMessage': messageText,
          'updatedAt': FieldValue.serverTimestamp(),
          'unreadCounts.$currentUserId': 0,
          'unreadCounts.$receiverId':
              receiverIsOnline ? 0 : FieldValue.increment(1),
        },
      );
    });
  }

  Future<void> markConversationAsRead(String conversationId) async {
    await firestore.collection('conversations').doc(conversationId).update({
      'unreadCounts.$_currentUserId': 0,
    });
  }

  Future<void> updateConversationPresence({
    required String conversationId,
    required bool isOnline,
  }) async {
    final currentUserId = _currentUserId;
    await firestore.collection('conversations').doc(conversationId).update({
      'onlineUsers': isOnline
          ? FieldValue.arrayUnion([currentUserId])
          : FieldValue.arrayRemove([currentUserId]),
      'unreadCounts.$currentUserId': 0,
    });
  }

  String get _currentUserId {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('Please sign in again.');
    }
    return user.uid;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/message/data/models/message_model.dart';

class MessageFirestoreService {
  MessageFirestoreService({
    required this.firestore,
    required this.firebaseAuth,
  });

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

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
          'unreadCounts.$receiverId': FieldValue.increment(1),
        },
      );
    });
  }

  Future<void> markConversationAsRead(String conversationId) async {
    await firestore.collection('conversations').doc(conversationId).update({
      'unreadCounts.$_currentUserId': 0,
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

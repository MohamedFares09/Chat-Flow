import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/home/data/models/conversation_model.dart';
import 'package:test_codex/features/home/data/models/home_user_model.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class HomeFirestoreService {
  HomeFirestoreService({
    required this.firestore,
    required this.firebaseAuth,
  });

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  Future<List<ConversationModel>> getConversations() async {
    final currentUserId = _currentUserId;
    final snapshot = await firestore
        .collection('conversations')
        .where('participantIds', arrayContains: currentUserId)
        .get();

    final conversations = snapshot.docs
        .map(
          (doc) => ConversationModel.fromFirestore(
            id: doc.id,
            currentUserId: currentUserId,
            json: doc.data(),
          ),
        )
        .toList();

    conversations.sort((a, b) {
      final firstDate = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      final secondDate = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
      return secondDate.compareTo(firstDate);
    });

    return conversations;
  }

  Future<List<HomeUserModel>> searchUsersByEmail(String email) async {
    final query = email.trim().toLowerCase();
    if (query.isEmpty) {
      return [];
    }

    final snapshot = await firestore
        .collection('users')
        .where('email', isGreaterThanOrEqualTo: query)
        .where('email', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(10)
        .get();

    return snapshot.docs
        .map((doc) => HomeUserModel.fromJson(doc.data()))
        .where((user) => user.uId != _currentUserId)
        .toList();
  }

  Future<ConversationModel> createConversationWithUser(
    HomeUserEntity user,
  ) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw CustomException('Please sign in again.');
    }

    final currentName = currentUser.displayName?.trim().isNotEmpty == true
        ? currentUser.displayName!.trim()
        : currentUser.email?.split('@').first ?? 'You';
    final conversationId = _conversationId(currentUser.uid, user.uId);
    final conversationRef = firestore.collection('conversations').doc(
          conversationId,
        );

    await conversationRef.set({
      'participantIds': [currentUser.uid, user.uId],
      'participantEmails': {
        currentUser.uid: currentUser.email ?? '',
        user.uId: user.email,
      },
      'participantPhotoUrls': {
        currentUser.uid: currentUser.photoURL,
        user.uId: user.photoUrl,
      },
      'participantNames': {
        currentUser.uid: currentName,
        user.uId: user.name,
      },
      'lastMessage': '',
      'unreadCounts': {
        currentUser.uid: 0,
        user.uId: 0,
      },
      'onlineUsers': <String>[],
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final doc = await conversationRef.get();
    return ConversationModel.fromFirestore(
      id: doc.id,
      currentUserId: currentUser.uid,
      json: doc.data() ?? {},
    );
  }

  String get _currentUserId {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('Please sign in again.');
    }
    return user.uid;
  }

  String _conversationId(String firstUserId, String secondUserId) {
    final ids = [firstUserId, secondUserId]..sort();
    return ids.join('_');
  }
}

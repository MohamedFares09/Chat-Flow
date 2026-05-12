import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/groups/data/models/group_model.dart';
import 'package:test_codex/features/home/data/models/conversation_model.dart';
import 'package:test_codex/features/home/data/models/home_user_model.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';

class GroupsFirebaseService {
  GroupsFirebaseService({required this.firestore, required this.firebaseAuth});

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  Stream<List<GroupModel>> watchGroups() {
    return firestore
        .collection('groups')
        .where('memberIds', arrayContains: _currentUserId)
        .snapshots()
        .map((snapshot) {
          final groups = snapshot.docs
              .map(
                (doc) => GroupModel.fromFirestore(id: doc.id, json: doc.data()),
              )
              .toList();
          groups.sort((a, b) {
            final firstDate =
                a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final secondDate =
                b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return secondDate.compareTo(firstDate);
          });
          return groups;
        });
  }

  Future<List<HomeUserModel>> getChattedUsers() async {
    final currentUserId = _currentUserId;
    final snapshot = await firestore
        .collection('conversations')
        .where('participantIds', arrayContains: currentUserId)
        .get();

    final users = <String, HomeUserModel>{};
    for (final doc in snapshot.docs) {
      final conversation = ConversationModel.fromFirestore(
        id: doc.id,
        currentUserId: currentUserId,
        json: doc.data(),
      );
      if (conversation.otherUser.uId.isNotEmpty) {
        users[conversation.otherUser.uId] = HomeUserModel.fromEntity(
          conversation.otherUser,
        );
      }
    }

    final items = users.values.toList();
    items.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return items;
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

  Future<GroupModel> createGroup({
    required String name,
    required List<HomeUserEntity> members,
  }) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) {
      throw CustomException('Please sign in again.');
    }

    final groupName = name.trim();
    if (groupName.isEmpty) {
      throw CustomException('Please enter a group name.');
    }
    if (members.isEmpty) {
      throw CustomException('Please choose at least one member.');
    }

    final currentUserName = currentUser.displayName?.trim().isNotEmpty == true
        ? currentUser.displayName!.trim()
        : currentUser.email?.split('@').first ?? 'You';
    final allMembers = <String, HomeUserModel>{
      currentUser.uid: HomeUserModel(
        uId: currentUser.uid,
        name: currentUserName,
        email: currentUser.email ?? '',
        photoUrl: currentUser.photoURL,
      ),
      for (final member in members)
        member.uId: HomeUserModel.fromEntity(member),
    }.values.toList();

    final groupRef = firestore.collection('groups').doc();
    final group = GroupModel(
      id: groupRef.id,
      name: groupName,
      members: allMembers,
      createdBy: currentUser.uid,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      lastMessage: '',
    );

    await groupRef.set({
      ...group.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return group;
  }

  String get _currentUserId {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('Please sign in again.');
    }
    return user.uid;
  }
}

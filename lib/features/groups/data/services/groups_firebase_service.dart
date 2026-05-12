import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_codex/core/errors/custom_exception.dart';
import 'package:test_codex/features/groups/data/models/group_model.dart';
import 'package:test_codex/features/home/data/models/conversation_model.dart';
import 'package:test_codex/features/home/data/models/home_user_model.dart';
import 'package:test_codex/features/home/domain/entities/home_user_entity.dart';
import 'package:test_codex/features/message/data/models/message_model.dart';

class GroupsFirebaseService {
  GroupsFirebaseService({
    required this.firestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

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
      photoUrl: null,
    );

    await groupRef.set({
      ...group.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return group;
  }

  Stream<GroupModel> watchGroup(String groupId) {
    return firestore.collection('groups').doc(groupId).snapshots().map((doc) {
      final data = doc.data();
      if (data == null) {
        throw CustomException('Group was not found.');
      }
      _ensureCurrentUserIsMemberData(data);
      return GroupModel.fromFirestore(id: doc.id, json: data);
    });
  }

  Stream<List<MessageModel>> getGroupMessages(String groupId) {
    return firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .asyncMap((snapshot) async {
          await _ensureCurrentUserIsMember(groupId);
          return snapshot.docs
              .map(
                (doc) => MessageModel.fromFirestore(
                  id: doc.id,
                  currentUserId: _currentUserId,
                  json: doc.data(),
                ),
              )
              .toList();
        });
  }

  Future<void> sendGroupMessage({
    required String groupId,
    required String text,
  }) async {
    final currentUserId = _currentUserId;
    final messageText = text.trim();
    if (messageText.isEmpty) {
      throw CustomException('Please write a message first.');
    }
    await _ensureCurrentUserIsMember(groupId);

    final groupRef = firestore.collection('groups').doc(groupId);
    final messageRef = groupRef.collection('messages').doc();

    await firestore.runTransaction((transaction) async {
      transaction.set(messageRef, {
        'text': messageText,
        'senderId': currentUserId,
        'type': 'text',
        'mediaUrl': null,
        'status': 'sent',
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(groupRef, {
        'lastMessage': messageText,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> sendGroupMediaMessage({
    required String groupId,
    required String filePath,
    required String type,
    required String text,
  }) async {
    final currentUserId = _currentUserId;
    final messageType = type.trim().toLowerCase();
    if (!['image', 'video', 'voice'].contains(messageType)) {
      throw CustomException('Unsupported message type.');
    }
    await _ensureCurrentUserIsMember(groupId);

    final file = File(filePath);
    if (!await file.exists()) {
      throw CustomException('Selected file was not found.');
    }

    final extension = _fileExtension(filePath, messageType);
    final ref = firebaseStorage.ref(
      'groups/$groupId/messages/$currentUserId/'
      '${DateTime.now().millisecondsSinceEpoch}.$extension',
    );
    await ref.putFile(file);
    final mediaUrl = await ref.getDownloadURL();

    final groupRef = firestore.collection('groups').doc(groupId);
    final messageRef = groupRef.collection('messages').doc();
    final previewText = _previewText(messageType, text);

    await firestore.runTransaction((transaction) async {
      transaction.set(messageRef, {
        'text': text.trim(),
        'senderId': currentUserId,
        'type': messageType,
        'mediaUrl': mediaUrl,
        'status': 'sent',
        'createdAt': FieldValue.serverTimestamp(),
      });
      transaction.update(groupRef, {
        'lastMessage': previewText,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Future<void> updateGroupMessage({
    required String groupId,
    required String messageId,
    required String text,
  }) async {
    final currentUserId = _currentUserId;
    final messageText = text.trim();
    if (messageText.isEmpty) {
      throw CustomException('Please write a message first.');
    }
    await _ensureCurrentUserIsMember(groupId);

    final groupRef = firestore.collection('groups').doc(groupId);
    final messageRef = groupRef.collection('messages').doc(messageId);

    await firestore.runTransaction((transaction) async {
      final messageSnapshot = await transaction.get(messageRef);
      final groupSnapshot = await transaction.get(groupRef);
      final messageData = messageSnapshot.data();
      if (messageData == null) {
        throw CustomException('Message was not found.');
      }
      if (messageData['senderId'] != currentUserId) {
        throw CustomException('You can only edit your messages.');
      }
      if (messageData['type'] != 'text') {
        throw CustomException('Only text messages can be edited.');
      }

      transaction.update(messageRef, {
        'text': messageText,
        'editedAt': FieldValue.serverTimestamp(),
      });

      final groupData = groupSnapshot.data() ?? {};
      if (groupData['lastMessage'] == messageData['text']) {
        transaction.update(groupRef, {
          'lastMessage': messageText,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<void> deleteGroupMessage({
    required String groupId,
    required String messageId,
  }) async {
    final currentUserId = _currentUserId;
    await _ensureCurrentUserIsMember(groupId);

    final groupRef = firestore.collection('groups').doc(groupId);
    final messageRef = groupRef.collection('messages').doc(messageId);

    await firestore.runTransaction((transaction) async {
      final messageSnapshot = await transaction.get(messageRef);
      final groupSnapshot = await transaction.get(groupRef);
      final messageData = messageSnapshot.data();
      if (messageData == null) {
        throw CustomException('Message was not found.');
      }
      if (messageData['senderId'] != currentUserId) {
        throw CustomException('You can only delete your messages.');
      }

      transaction.delete(messageRef);

      final groupData = groupSnapshot.data() ?? {};
      if (groupData['lastMessage'] ==
          _previewText(
            messageData['type'] ?? 'text',
            messageData['text'] ?? '',
          )) {
        transaction.update(groupRef, {
          'lastMessage': 'Message deleted',
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  Future<GroupModel> updateGroupDetails({
    required String groupId,
    required String name,
    String? imagePath,
  }) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      throw CustomException('Please enter a group name.');
    }

    final groupRef = firestore.collection('groups').doc(groupId);
    final groupDoc = await groupRef.get();
    final groupData = groupDoc.data();
    if (groupData == null) {
      throw CustomException('Group was not found.');
    }
    _ensureCurrentUserIsMemberData(groupData);

    final savedPhotoUrl = groupData['photoUrl'];
    final photoUrl = await _uploadGroupImage(
      groupId: groupId,
      imagePath: imagePath,
      fallbackPhotoUrl:
          savedPhotoUrl is String && savedPhotoUrl.trim().isNotEmpty
          ? savedPhotoUrl
          : null,
    );

    await groupRef.set({
      'name': cleanName,
      'photoUrl': photoUrl,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    final updatedDoc = await groupRef.get();
    return GroupModel.fromFirestore(
      id: updatedDoc.id,
      json: updatedDoc.data() ?? {},
    );
  }

  Future<void> _ensureCurrentUserIsMember(String groupId) async {
    final doc = await firestore.collection('groups').doc(groupId).get();
    final data = doc.data();
    if (data == null) {
      throw CustomException('Group was not found.');
    }
    _ensureCurrentUserIsMemberData(data);
  }

  void _ensureCurrentUserIsMemberData(Map<String, dynamic> data) {
    final memberIds = List<String>.from(data['memberIds'] ?? []);
    if (!memberIds.contains(_currentUserId)) {
      throw CustomException('You are not a member of this group.');
    }
  }

  String get _currentUserId {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw CustomException('Please sign in again.');
    }
    return user.uid;
  }

  String _fileExtension(String filePath, String type) {
    final fileName = filePath.split(Platform.pathSeparator).last;
    if (fileName.contains('.')) {
      return fileName.split('.').last;
    }

    return switch (type) {
      'image' => 'jpg',
      'video' => 'mp4',
      'voice' => 'm4a',
      _ => 'file',
    };
  }

  Future<String?> _uploadGroupImage({
    required String groupId,
    required String? imagePath,
    required String? fallbackPhotoUrl,
  }) async {
    final cleanPath = imagePath?.trim();
    if (cleanPath == null || cleanPath.isEmpty) {
      return fallbackPhotoUrl;
    }

    final file = File(cleanPath);
    if (!await file.exists()) {
      throw CustomException('Selected group image was not found.');
    }

    final fileName = file.uri.pathSegments.last;
    final extension = fileName.contains('.') ? fileName.split('.').last : 'jpg';
    final ref = firebaseStorage.ref(
      'groups/$groupId/profile_${DateTime.now().millisecondsSinceEpoch}.$extension',
    );
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  String _previewText(String type, String text) {
    final cleanText = text.trim();
    if (cleanText.isNotEmpty) {
      return cleanText;
    }

    return switch (type) {
      'image' => 'Photo',
      'video' => 'Video',
      'voice' => 'Voice message',
      _ => 'Attachment',
    };
  }
}

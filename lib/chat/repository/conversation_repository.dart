import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/models.dart';

class ConversationsRepository {
  ConversationsRepository._();

  static final ConversationsRepository _instance = ConversationsRepository._();

  static ConversationsRepository getInstance() => _instance;

  final CollectionReference _conversationCollection =
      FirebaseFirestore.instance.collection('conversation');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<ConversationModel?> getConversationId(
      {required String user1Id,
      required String user2Id,
      bool isGroup = false}) async {
    late QuerySnapshot<Object?> conversationData;
    conversationData = await _conversationCollection
        .where(ConversationField.participantsIds, isEqualTo: [user1Id, user2Id])
        .where(ConversationField.isGroup, isEqualTo: isGroup)
        .get();
    if (conversationData.docs.isEmpty) {
      conversationData = await _conversationCollection
          .where(ConversationField.participantsIds,
              isEqualTo: [user2Id, user1Id])
          .where(ConversationField.isGroup, isEqualTo: isGroup)
          .get();
    }
    print(conversationData.docs.length);
    if (conversationData.docs.isNotEmpty) {
      return ConversationModel.fromMap(
          conversationData.docs.first.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<ConversationModel> createConversation(
      {required ConversationModel conversation}) async {
    final String newConversationId = _conversationCollection.doc().id;
    final x = await _conversationCollection
        .doc(newConversationId)
        .set(conversation.copyWith(id: newConversationId).toMap());
    return conversation.copyWith(id: newConversationId);
  }

  Future<String> acceptRequest(
      {required ConversationModel conversation}) async {
    final idList = conversation.requestAcceptedIds;
    await _conversationCollection.doc(conversation.id).set(conversation
        .copyWith(
            requestAcceptedIds: idList
              ..add(FirebaseAuth.instance.currentUser!.uid))
        .toMap());

    return '';
  }

  Future<ConversationModel> updateConversation(
      {required ConversationModel conversation}) async {
    await _conversationCollection
        .doc(conversation.id)
        .update(conversation.toMap());
    return conversation;
  }

  Future<ConversationModel?> getConversation(
      {required String conversationId}) async {
    final DocumentSnapshot<Object?> conversationData =
        await _conversationCollection.doc(conversationId).get();
    if (conversationData.exists) {
      return ConversationModel.fromMap(
          conversationData.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<ConversationModel>> getConversations({
    required String userId,
  }) {
    return _conversationCollection
        .where(ConversationField.participantsIds, arrayContainsAny: [userId])
        .orderBy(ConversationField.lastUpdateTime, descending: true)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<ConversationModel>>.fromHandlers(
          handleData:
              (QuerySnapshot data, EventSink<List<ConversationModel>> sink) {
            final snaps = data.docs.map((doc) => doc.data()).toList();
            final msgs = snaps
                .map((json) =>
                    ConversationModel.fromMap(json as Map<String, dynamic>))
                .toList();
            sink.add(msgs);
          },
        ));
  }

  Stream<List<UserChatModel>> getUsers() {
    return _userCollection.snapshots().transform(StreamTransformer<
        QuerySnapshot<Map<String, dynamic>>, List<UserChatModel>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<UserChatModel>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final msgs = snaps
            .map((json) => UserChatModel.fromMap(json as Map<String, dynamic>))
            .toList();
        sink.add(msgs);
      },
    ));
  }

  Stream<ConversationModel> getGroupIcon(
      {required ConversationModel conversation}) {
    return _conversationCollection.doc(conversation.id).snapshots().map(
        (event) =>
            ConversationModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<ConversationModel> getConversationModel(
      {required ConversationModel conversation}) async {
    final doc = await _conversationCollection.doc(conversation.id).get();

    return ConversationModel.fromMap(doc.data() as Map<String, dynamic>);
  }
  Future<ConversationModel> getConversationModelById(
      {required String conversationId}) async {
    final doc = await _conversationCollection.doc(conversationId).get();

    return ConversationModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  UploadTask uploadFile(File image, String fileName) {
    Reference reference =
        FirebaseStorage.instance.ref().child("chat/$fileName");
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }
}

import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:medzo/chat/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  late String _conversationId;
  late CollectionReference _chatCollection;

  ChatRepository({required String conversationId})
      : _conversationId = conversationId {
    _chatCollection =
        FirebaseFirestore.instance.collection('chats/$conversationId/messages');
  }

  Future<MessageModel> sendMessage({required MessageModel message}) async {
    final newDocRef = _chatCollection.doc();
    final MessageModel messageModel = message.copyWith(
      id: newDocRef.id,
    );
    await newDocRef.set(messageModel.toMap());
    return messageModel;
  }

  Stream<List<MessageModel>> getMessages({
    required String conversationId,
  }) {
    return _chatCollection
        .orderBy(MessageField.createdTime, descending: true)
        .snapshots()
        .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
            List<MessageModel>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<MessageModel>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final msgs = snaps
            .map((json) => MessageModel.fromMap(json as Map<String, dynamic>))
            .toList();

        sink.add(msgs);
      },
    ));
  }
}

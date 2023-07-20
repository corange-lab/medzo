import 'dart:async';

import 'package:medzo/chat/models/models.dart';
import 'package:medzo/chat/repository/chat_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatBloc {
  Future<MessageModel> sendMessage(String conversationId, String content,
      {bool isUrl = true}) async {
    // Send message to server
    final MessageModel message = MessageModel(
        content: isUrl ? null : content,
        conversationId: conversationId,
        createdTime: DateTime.now().toUtc(),
        senderId: FirebaseAuth.instance.currentUser!.uid,
        imageUrl: isUrl ? content : null,
        isImage: isUrl);

    final MessageModel finalMessage =
        await ChatRepository(conversationId: conversationId)
            .sendMessage(message: message);

    return finalMessage;
  }

  Stream<List<MessageModel>> getMessages({
    required String conversationId,
  }) {
    return ChatRepository(conversationId: conversationId)
        .getMessages(conversationId: conversationId);
  }
}

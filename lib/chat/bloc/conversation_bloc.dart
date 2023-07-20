import 'package:flutter/foundation.dart';

import '../../chat/repository/conversation_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/models.dart';

class ConversationsBloc {
  static Future<ConversationModel?> getConversationId(
      {required String user1Id, required String user2Id}) async {
    if (kDebugMode) {
      print("UserId1::$user1Id UserId2::$user2Id");
    }
    return ConversationsRepository.getInstance()
        .getConversationId(user1Id: user1Id, user2Id: user2Id);
  }

  // User1 is the current user
  // User2 is the other user
  static Future<ConversationModel> createConversation(List<ChatUserModel> users,
      {String? groupName}) async {
    final ConversationModel newConversationId =
        await ConversationsRepository.getInstance().createConversation(
      conversation: ConversationModel(
          lastUpdateTime: DateTime.now().toUtc(),
          createdTime: DateTime.now().toUtc(),
          lastMessageIsImage: false,
          groupName: groupName,
          participantsIds: users.map((e) => e.userId).toList(),
          requestAcceptedIds: [FirebaseAuth.instance.currentUser!.uid],
          isGroup: groupName != null ? true : false,
          participants: users),
    );
    return newConversationId;
  }

  static Future<ConversationModel> updateConversation(
      {required ConversationModel conversation}) async {
    return await ConversationsRepository.getInstance()
        .updateConversation(conversation: conversation);
  }

  static Future<ConversationModel> updateUnreadCount(
      {required ConversationModel conversation}) async {
    final newConversationModel = await ConversationsRepository.getInstance()
        .getConversationModel(conversation: conversation);

    List<ChatUserModel> list = [];
    for (var element in newConversationModel.participants) {
      if (element.userId == FirebaseAuth.instance.currentUser!.uid) {
        list.add(element.copyWith(numberOfUnreadMessages: 0));
      } else {
        list.add(element);
      }
    }
    return ConversationsRepository.getInstance().updateConversation(
        conversation: newConversationModel.copyWith(participants: list));
  }

  static Future<ConversationModel> getConversationModelById(
      {required String conversationId}) async {
    return ConversationsRepository.getInstance()
        .getConversationModelById(conversationId: conversationId);
  }

  static Future<ConversationModel> updateGroupIcon(
      {required ConversationModel conversation,
      required String imageUrl}) async {
    return ConversationsRepository.getInstance().updateConversation(
        conversation: conversation.copyWith(imageUrl: imageUrl));
  }

  static Future<ConversationModel> updateGroupName(
      {required ConversationModel conversation,
      required String grpName}) async {
    return ConversationsRepository.getInstance().updateConversation(
        conversation: conversation.copyWith(groupName: grpName));
  }

  static Future<ConversationModel> updateGroupMembers(
      {required ConversationModel conversation,
      required List<ChatUserModel> participants,
      required List<String> participantsIds,
      required List<String> requestAcceptedIds}) async {
    return ConversationsRepository.getInstance().updateConversation(
        conversation: conversation.copyWith(
            participants: participants,
            participantsIds: participantsIds,
            requestAcceptedIds: requestAcceptedIds));
  }

  static Future<ConversationModel?> getConversation(
      {required String conversationId}) async {
    return ConversationsRepository.getInstance()
        .getConversation(conversationId: conversationId);
  }
}

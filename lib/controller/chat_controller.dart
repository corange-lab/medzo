import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/main.dart';
import 'package:medzo/model/chat_room.dart';
import 'package:medzo/model/message_model.dart';

class ChatController extends GetxController {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController messageText = TextEditingController();

  ChatRoom? chatRoom;

  CollectionReference conversationRef =
      FirebaseFirestore.instance.collection('conversation');

  Future<ChatRoom?> getChatRoom(String targetUser) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("conversation")
        .where("participants.${currentUser}", isEqualTo: true)
        .where("participants.${targetUser}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var map = snapshot.docs[0].data();
      ChatRoom existChatRoom = ChatRoom.fromMap(map as Map<String, dynamic>);

      chatRoom = existChatRoom;
    } else {
      ChatRoom newChatRoom = ChatRoom(
          chatRoomId: uuid.v1(),
          lastMessage: "",
          participants: {currentUser: true, targetUser: true});

      await conversationRef
          .doc(newChatRoom.chatRoomId)
          .set(newChatRoom.toMap());

      chatRoom = newChatRoom;
    }
    return chatRoom;
  }

  Future<void> sendMessage() async {
    String message = messageText.text.trim();
    messageText.clear();

    if (message.isNotEmpty) {
      messageModel newMessage = messageModel(
          messageId: uuid.v1(),
          message: message,
          sender: currentUser,
          createdTime: DateTime.now(),
          isSeen: false);

      conversationRef
          .doc(chatRoom!.chatRoomId)
          .collection("messages")
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      chatRoom!.lastMessage = message;

      conversationRef.doc(chatRoom!.chatRoomId).set(chatRoom!.toMap());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMessages() {
    return conversationRef
        .doc(chatRoom?.chatRoomId)
        .collection('messages')
        .orderBy("createdTime", descending: true)
        .snapshots();
  }
}

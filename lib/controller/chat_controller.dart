import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  getChatUser() {
    return conversationRef
        .where("participants.${currentUser}", isEqualTo: true)
        .snapshots();
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
      chatRoom!.lastMessageTime = DateTime.now();

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

  String formatTimestamp(String timestamp) {
    final now = DateTime.now();

    String withoutOffset = timestamp.split(" UTC")[0];

    String datePart = withoutOffset.split(' ')[0];
    String timePart = withoutOffset.split(' ')[1];

    String combined = '$datePart $timePart';

    final inputFormat = DateFormat("y-MM-dd H:m:s.S");

    DateTime messageDate;

    try {
      messageDate = inputFormat.parse(combined);
      print("$messageDate data");
    } catch (e) {
      print("Error parsing date: $e");
      return "Unknown date";
    }

    final difference = now.difference(messageDate);

    if (difference.inDays == 0) {
      final timeFormat = DateFormat('jm');
      return timeFormat.format(messageDate);
    } else if (difference.inDays == 1) {
      return "yesterday";
    } else {
      final dateFormat = DateFormat('d MMMM y');
      return dateFormat.format(messageDate);
    }
  }
}
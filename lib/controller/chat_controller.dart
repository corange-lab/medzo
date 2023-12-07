import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medzo/main.dart';
import 'package:medzo/model/chat_room.dart';
import 'package:medzo/model/message_model.dart';

class ChatController extends GetxController {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController messageText = TextEditingController();

  ChatRoom? chatRoom;

  bool? youBlockedReceiver, doesReceiverBlockedYou;

  ChatController({this.chatRoom});

  @override
  void onInit() {
    initSetup(chatRoom?.participants?.keys.first != currentUser
        ? currentUser
        : chatRoom?.participants?.keys.last);
    super.onInit();
  }

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

  Stream<QuerySnapshot<Object?>> getChatUser() {
    return conversationRef
        .where("participants.${currentUser}", isEqualTo: true)
        // .orderBy("lastMessageTime", descending: true)
        .snapshots();
  }

  Future<void> sendMessage(
      {required BuildContext context, String? receiverID}) async {
    if (receiverID != null) {
      if (youBlockedReceiver == null || doesReceiverBlockedYou == null) {
        await initSetup(receiverID);
      }
      if ((youBlockedReceiver != null && youBlockedReceiver!) ||
          (doesReceiverBlockedYou != null && doesReceiverBlockedYou!)) {
        if (!doesReceiverBlockedYou!) {
          // Display a notification or message indicating that the recipient has blocked you
          showBlockedNotification(context,
              message: 'This user has blocked you');
        } else {
          // Display a notification or message indicating that you have blocked the recipient
          showBlockedNotification(context,
              message: 'You have blocked this user');
        }
      } else {
        _sendMessage();
      }
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
      // print("$messageDate data");
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

  void _sendMessage() {
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

  void showBlockedNotification(BuildContext context,
      {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: Duration(seconds: 2)));
  }

  Future<bool> isUserBlocked({
    required String currentUserID,
    required String otherUserID,
  }) async {
    var blockedUsersRef =
        FirebaseFirestore.instance.collection('blocked_users');

    // Check if the other user is in the blocked_users collection
    DocumentSnapshot doc = await blockedUsersRef.doc(currentUserID).get();

    // Return true if the other user is blocked, false otherwise
    return doc.exists && doc['blockedUserId'] != otherUserID;
  }

  Future<void> initSetup([String? receiverID]) async {
    if (receiverID == null) {
      return;
    }
    youBlockedReceiver = await isUserBlocked(
        currentUserID: currentUser, otherUserID: receiverID);

    doesReceiverBlockedYou = await isUserBlocked(
        currentUserID: receiverID, otherUserID: currentUser);
  }
}

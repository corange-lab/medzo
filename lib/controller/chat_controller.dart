import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/main.dart';
import 'package:medzo/model/chat_room.dart';
import 'package:medzo/model/message_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/utils.dart';

class ChatController extends GetxController {
  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  TextEditingController messageText = TextEditingController();

  AllUserController allUserController = Get.put(AllUserController());

  ChatRoom? chatRoom;

  bool? youBlockedReceiver, doesReceiverBlockedYou;

  ChatController({this.chatRoom});

  @override
  void onInit() {
    // initSetup(chatRoom?.participants?.keys.first != currentUser
    //     ? currentUser
    //     : chatRoom?.participants?.keys.last);
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
    if (receiverID == null) {
      print("sendMessage: receiverID is null");
      return;
    }

    await initSetup(receiverID);

    print(
        "sendMessage: youBlockedReceiver = $youBlockedReceiver, doesReceiverBlockedYou = $doesReceiverBlockedYou");

    if (youBlockedReceiver == true) {
      print("sendMessage: Blocked by You");
      showBlockedNotification(context, message: 'You have blocked this user');
      return;
    } else if (doesReceiverBlockedYou == true) {
      print("sendMessage: Blocked by Receiver");
      showBlockedNotification(context, message: 'This user has blocked you');
      return;
    } else {
      if (!Utils.hasAbusiveWords(messageText.text.trim())) {
        _sendMessage();
      } else {
        toast(message: "You can't enter abuse words.");
        return;
      }

      print("sendMessage: Sending message");
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
      SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: AppColors.primaryColor),
    );
  }

  Future<bool> isUserBlocked(String myUserId, String blockedUserId) async {
    try {
      bool? isBlocked =
          await allUserController.fetchIsBlockedStatus(blockedUserId);

      if (!isBlocked!) {
        List<dynamic> blockedUserIds = allUserController.blockedUserList;
        return blockedUserIds.contains(blockedUserId);
      } else {
        return true;
      }
    } catch (e) {
      print('Error in isUserBlocked: $e');
    }
    return false;
  }

  Future<void> initSetup([String? receiverID]) async {
    if (receiverID == null) {
      return;
    }
    youBlockedReceiver = await isUserBlocked(currentUser, receiverID);

    doesReceiverBlockedYou = await isUserBlocked(receiverID, currentUser);
  }
}

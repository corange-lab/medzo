import 'package:medzo/utils/firebase_utils.dart';

class ChatRoom {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  DateTime? lastMessageTime;

  ChatRoom({this.chatRoomId,
    this.participants,
    this.lastMessage,
    this.lastMessageTime});

  ChatRoom.fromMap(Map<String, dynamic> map) {
    chatRoomId = map['chatRoomId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
    lastMessageTime = map['lastMessageTime'] != null
        ? FirebaseUtils.timestampToDateTime(map['lastMessageTime'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['participants'] = participants;
    data['lastMessage'] = lastMessage;
    data['lastMessageTime'] = lastMessageTime;
    return data;
  }
}

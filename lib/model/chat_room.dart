class ChatRoom {
  String? chatRoomId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoom({this.chatRoomId, this.participants,this.lastMessage});

  ChatRoom.fromMap(Map<String, dynamic> map) {
    chatRoomId = map['chatRoomId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatRoomId'] = chatRoomId;
    data['participants'] = participants;
    data['lastMessage'] = lastMessage;
    return data;
  }
}

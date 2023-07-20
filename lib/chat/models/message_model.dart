part of 'models.dart';

class MessageField {
  static const String createdTime = 'createdTime';
  static const String imageUrl = 'imageUrl';
}

class MessageModel {
  final String? id;
  final String conversationId;
  final String? content;
  final DateTime createdTime;
  final String senderId;
  final bool isImage;
  final String? imageUrl;
  MessageModel(
      {this.id,
      required this.conversationId,
      this.content,
      required this.createdTime,
      required this.senderId,
      this.isImage = false,
      this.imageUrl});

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? content,
    DateTime? createdTime,
    String? senderId,
    bool? isImage,
    String? imageUrl,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      createdTime: createdTime ?? this.createdTime,
      senderId: senderId ?? this.senderId,
      isImage: isImage ?? this.isImage,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'conversationId': conversationId,
      'content': content,
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'senderId': senderId,
      'isImage': isImage,
      'imageUrl': imageUrl,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      conversationId: map['conversationId'],
      content: map['content'],
      createdTime: map['createdTime'] == null ? DateTime.now() : Utils.toDateTime(map['createdTime'])!,
      senderId: map['senderId'],
      isImage: map['isImage'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, conversationId: $conversationId, content: $content, createdTime: $createdTime, senderId: $senderId, isImage: $isImage, imageUrl: $imageUrl)';
  }

  // ChatBubbleCornerStyle getChatBubbleStyle() {
  //   if (senderId == FirebaseAuth.instance.currentUser?.uid) {
  //     return ChatBubbleCornerStyle.bottomLeftSide;
  //   } else {
  //     return ChatBubbleCornerStyle.topLeftSide;
  //   }
  // }

// 1 -> single msg  (  four side corner  )
// 2 -> two msg  ( top side corner)
// 3 -> two msg ( bottom side corner)
// 4 -> multiple msg ( no side corner)

  ChatBubbleCornerStyle _chatBubbleCornerStyle =
      ChatBubbleCornerStyle.bothLeftSide;
  set setChatBubbleCornerStyle(ChatBubbleCornerStyle number) {
    _chatBubbleCornerStyle = number;
  }

  get getChatBubbleCornerStyle => _chatBubbleCornerStyle;
}

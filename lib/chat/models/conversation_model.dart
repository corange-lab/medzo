part of 'models.dart';

class ConversationField {
  static const String createdTime = 'createdTime';
  static const String imageUrl = 'imageUrl';
  static const String participantsIds = 'participantsIds';
  static const String lastMessageTime = 'lastMessageTime';
  static const String lastUpdateTime = 'lastUpdateTime';
  static const String isGroup = 'isGroup';
}

class ConversationModel {
  // basic details
  final String? id;
  final DateTime createdTime;

  // message details
  final DateTime lastUpdateTime;
  final DateTime? lastMessageTime;
  final String? lastMessageContent;
  final String? lastMessageSenderId;
  final String? lastMessageImageUrl;
  final bool lastMessageIsImage;

  // participants details
  final List<String> participantsIds;
  final List<String> requestAcceptedIds;

  // group details
  final bool isGroup;
  final String? groupName;
  final String? imageUrl;
  final List<ChatUserModel> participants;

  ConversationModel({
    this.id,
    required this.createdTime,
    required this.lastUpdateTime,
    this.lastMessageTime,
    this.lastMessageContent,
    this.lastMessageSenderId,
    this.lastMessageImageUrl,
    required this.lastMessageIsImage,
    required this.participantsIds,
    required this.requestAcceptedIds,
    this.imageUrl,
    required this.participants,
    this.isGroup = false,
    this.groupName,
  });

  ConversationModel copyWith({
    String? id,
    DateTime? createdTime,
    DateTime? lastUpdateTime,
    DateTime? lastMessageTime,
    String? lastMessageContent,
    String? lastMessageSenderId,
    String? lastMessageImageUrl,
    bool? lastMessageIsImage,
    List<String>? participantsIds,
    List<String>? requestAcceptedIds,
    String? imageUrl,
    List<ChatUserModel>? participants,
    bool? isGroup,
    String? groupName,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      createdTime: createdTime ?? this.createdTime,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastMessageContent: lastMessageContent ?? this.lastMessageContent,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageImageUrl: lastMessageImageUrl ?? this.lastMessageImageUrl,
      lastMessageIsImage: lastMessageIsImage ?? this.lastMessageIsImage,
      participantsIds: participantsIds ?? this.participantsIds,
      requestAcceptedIds: requestAcceptedIds ?? this.requestAcceptedIds,
      imageUrl: imageUrl ?? this.imageUrl,
      participants: participants ?? this.participants,
      isGroup: isGroup ?? this.isGroup,
      groupName: groupName ?? this.groupName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdTime': Utils.fromDateTimeToJson(createdTime),
      'lastUpdateTime': Utils.fromDateTimeToJson(lastUpdateTime),
      'lastMessageTime': lastMessageTime == null
          ? null
          : Utils.fromDateTimeToJson(lastMessageTime!),
      'lastMessageContent': lastMessageContent,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageImageUrl': lastMessageImageUrl,
      'lastMessageIsImage': lastMessageIsImage,
      'participantsIds': participantsIds,
      'requestAcceptedIds': requestAcceptedIds,
      'imageUrl': imageUrl,
      'participants': participants.map((x) => x.toMap()).toList(),
      'isGroup': isGroup,
      'groupName': groupName,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
        id: map['id'] != null ? map['id'] as String : null,
        createdTime: map['createdTime'] == null
            ? DateTime.now()
            : Utils.toDateTime(map['createdTime'])!,
        lastUpdateTime: map['lastUpdateTime'] == null
            ? DateTime.now()
            : Utils.toDateTime(map['lastUpdateTime'])!,
        lastMessageTime: Utils.toDateTime(map['lastMessageTime']),
        lastMessageContent: map['lastMessageContent'],
        lastMessageSenderId: map['lastMessageSenderId'],
        lastMessageImageUrl: map['lastMessageImageUrl'],
        lastMessageIsImage: (map['lastMessageIsImage'] as bool?) ?? false,
        participantsIds:
            List<String>.from(map['participantsIds'] as List<dynamic>),
        requestAcceptedIds:
            List<String>.from(map['requestAcceptedIds'] as List<dynamic>),
        imageUrl: map['imageUrl'],
        participants: List<ChatUserModel>.from(
          (map['participants'] as List<dynamic>).map<ChatUserModel>(
            (x) => ChatUserModel.fromMap(x as Map<String, dynamic>),
          ),
        ),
        isGroup: map["isGroup"] ?? false,
        groupName: map['groupName']);
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) =>
      ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationModel(id: $id, createdTime: $createdTime, lastUpdateTime: $lastUpdateTime, lastMessageTime: $lastMessageTime, lastMessageContent: $lastMessageContent, lastMessageSenderId: $lastMessageSenderId, lastMessageImageUrl: $lastMessageImageUrl, lastMessageIsImage: $lastMessageIsImage, participantsIds: $participantsIds, requestAcceptedIds: $requestAcceptedIds, imageUrl: $imageUrl, participants: $participants, isGroup: $isGroup, groupName: $groupName)';
  }
}

class ChatUserModel {
  final int numberOfUnreadMessages;
  final String profileImage;
  final String userId;
  final String name;

  ChatUserModel({
    required this.numberOfUnreadMessages,
    required this.profileImage,
    required this.userId,
    required this.name,
  });

  ChatUserModel copyWith({
    int? numberOfUnreadMessages,
    String? profileImage,
    String? userId,
    String? name,
  }) {
    return ChatUserModel(
      numberOfUnreadMessages:
          numberOfUnreadMessages ?? this.numberOfUnreadMessages,
      profileImage: profileImage ?? this.profileImage,
      userId: userId ?? this.userId,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numberOfUnreadMessages': numberOfUnreadMessages,
      'profileImage': profileImage,
      'userId': userId,
      'name': name
    };
  }

  factory ChatUserModel.fromMap(Map<String, dynamic> map) {
    return ChatUserModel(
      numberOfUnreadMessages: map['numberOfUnreadMessages'] as int,
      profileImage: map['profileImage'] as String? ?? staticImage,
      userId: map['userId'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatUserModel.fromJson(String source) =>
      ChatUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatUserModel(numberOfUnreadMessages: $numberOfUnreadMessages, profileImage: $profileImage, userId: $userId, name: $name)';
}

const String staticImage =
    "https://firebasestorage.googleapis.com/v0/b/barki-511d1.appspot.com/o/staticPicture%2Fblank-profile-picture-973460__340.png?alt=media&token=517e68b0-cdc8-48e5-a2b7-1ba75312bdb0";
const String staticGroupImage =
    "https://firebasestorage.googleapis.com/v0/b/barki-511d1.appspot.com/o/staticPicture%2Fgroup.png?alt=media&token=6f42abbd-5a85-4660-9397-9e4bd8ac6334";

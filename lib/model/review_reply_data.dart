import 'package:medzo/utils/firebase_utils.dart';

class ReviewReplyModel {
  String? id;
  String? userId;
  String? reply;
  DateTime? repliedTime;
  List<String?>? upvoteUsers;
  List<String?>? downvoteUsers;

  ReviewReplyModel({
    this.id,
    this.userId,
    this.reply,
    this.repliedTime,
    this.upvoteUsers,
    this.downvoteUsers,
  });

  ReviewReplyModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    userId = map["userId"];
    reply = map["reply"];
    repliedTime = map['repliedTime'] != null
        ? FirebaseUtils.timestampToDateTime(map['repliedTime'])
        : null;
    upvoteUsers = map['upvoteUsers'] != null
        ? List<String?>.from(map['upvoteUsers'])
        : null;
    downvoteUsers = map['downvoteUsers'] != null
        ? List<String?>.from(map['downvoteUsers'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["userId"] = userId;
    data["reply"] = reply;
    if (this.repliedTime != null) {
      data['repliedTime'] = this.repliedTime;
    }
    if (this.upvoteUsers != null) {
      data['upvoteUsers'] = this.upvoteUsers;
    }
    if (this.downvoteUsers != null) {
      data['downvoteUsers'] = this.downvoteUsers;
    }
    return data;
  }

  // copyWith method
  ReviewReplyModel copyWith({
    String? id,
    String? userId,
    String? reply,
    DateTime? repliedTime,
    List<String?>? likedUsers,
  }) {
    return ReviewReplyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reply: reply ?? this.reply,
      repliedTime: repliedTime ?? this.repliedTime,
      upvoteUsers: upvoteUsers ?? this.upvoteUsers,
      downvoteUsers: downvoteUsers ?? this.downvoteUsers,
    );
  }
}

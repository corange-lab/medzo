import '../utils/firebase_utils.dart';

class CommentData {
  String? id;
  String? content;
  String? commentUserId;
  List<String?>? likedUsers;
  DateTime? createdTime;
  DateTime? updatedTime;

  CommentData({
    this.id,
    required this.content,
    required this.commentUserId,
    this.likedUsers,
    this.createdTime,
    this.updatedTime,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'],
      content: json['content'],
      commentUserId: json['commentUserId'],
      likedUsers: json['likedUsers'] != null
          ? List<String?>.from(json['likedUsers'])
          : null,
      createdTime: json['createdTime'] != null
          ? FirebaseUtils.timestampToDateTime(json['createdTime'])
          : null,
      updatedTime: json['updatedTime'] != null
          ? FirebaseUtils.timestampToDateTime(json['updatedTime'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['commentUserId'] = this.commentUserId;
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers;
    }
    if (this.createdTime != null) {
      data['createdTime'] = this.createdTime;
    }
    if (this.updatedTime != null) {
      data['updatedTime'] = this.updatedTime;
    }
    return data;
  }

  // Named constructor "create"
  factory CommentData.create({
    required String content,
    required String commentUserId,
    DateTime? createdTime,
  }) {
    return CommentData(
      content: content,
      commentUserId: commentUserId,
      createdTime: createdTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          commentUserId == other.commentUserId;

  @override
  int get hashCode => id.hashCode ^ commentUserId.hashCode;
}

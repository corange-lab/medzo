import 'package:medzo/model/report_data.dart';

import '../utils/firebase_utils.dart';

class CommentData {
  String? id;
  String? content;
  String? commentUserId;
  List<String?>? likedUsers;
  List<ReportData>? reportDataList;
  List<String?>? upvoteUsers;
  List<String?>? downvoteUsers;
  List<CommentData>? commentComments;
  DateTime? createdTime;
  DateTime? updatedTime;

  CommentData({
    this.id,
    required this.content,
    required this.commentUserId,
    this.likedUsers,
    this.reportDataList,
    this.upvoteUsers,
    this.downvoteUsers,
    this.commentComments,
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
      reportDataList: json['reportDataList'] != null
          ? List<ReportData>.from(
              json['reportDataList'].map((x) => ReportData.fromMap(x)))
          : null,
      upvoteUsers: json['upvoteUsers'] != null
          ? List<String?>.from(json['upvoteUsers'])
          : null,
      downvoteUsers: json['downvoteUsers'] != null
          ? List<String?>.from(json['downvoteUsers'])
          : null,
      commentComments: json['commentComments'] != null
          ? List<CommentData>.from(
              json['commentComments'].map((x) => CommentData.fromJson(x)))
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
    if (this.reportDataList != null) {
      data['reportDataList'] = this
          .reportDataList!
          .map((reportData) => reportData is Map<String, dynamic>
              ? reportData
              : reportData.toMap())
          .toList();
    }
    if (this.upvoteUsers != null) {
      data['upvoteUsers'] = this.upvoteUsers;
    }
    if (this.downvoteUsers != null) {
      data['downvoteUsers'] = this.downvoteUsers;
    }
    if (this.commentComments != null) {
      data['commentComments'] = this
          .commentComments!
          .map((comment) =>
              comment is Map<String, dynamic> ? comment : comment.toMap())
          .toList();
    }
    if (this.createdTime != null) {
      data['createdTime'] = this.createdTime;
    }
    if (this.updatedTime != null) {
      data['updatedTime'] = this.updatedTime;
    }
    return data;
  }

  CommentData copyWith({
    String? id,
    String? content,
    String? commentUserId,
    List<String?>? likedUsers,
    List<ReportData>? reportDataList,
    List<String?>? upvoteUsers,
    List<String?>? downvoteUsers,
    List<CommentData>? commentComments,
    DateTime? createdTime,
    DateTime? updatedTime,
  }) {
    return CommentData(
      id: id ?? this.id,
      content: content ?? this.content,
      commentUserId: commentUserId ?? this.commentUserId,
      likedUsers: likedUsers ?? this.likedUsers,
      reportDataList: reportDataList ?? this.reportDataList,
      upvoteUsers: upvoteUsers ?? this.upvoteUsers,
      downvoteUsers: downvoteUsers ?? this.downvoteUsers,
      commentComments: commentComments ?? this.commentComments,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
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

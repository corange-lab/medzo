import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medzo/model/comment_data.dart';
import 'package:medzo/utils/firebase_utils.dart';

class PostData {
  final String? id;
  final String? creatorId;
  final String? description;
  List<PostImageData>? postImages;
  List<CommentData>? postComments;
  List<String?>? likedUsers;
  bool? isFavourite;
  final DateTime? createdTime;
  final DateTime? updatedTime;

  PostData._({
    this.id,
    this.creatorId,
    this.description,
    this.postImages,
    this.postComments,
    this.likedUsers,
    this.createdTime,
    this.updatedTime,
  });

  PostData.create({
    this.id,
    required this.creatorId,
    required this.description,
    required this.postImages,
    this.postComments,
    this.likedUsers,
    required this.createdTime,
    this.updatedTime,
  });

  PostData.update({
    required this.id,
    required this.creatorId,
    required this.description,
    this.postImages,
    this.postComments,
    this.likedUsers,
    this.createdTime,
    required this.updatedTime,
  });

  PostData.delete({
    required this.id,
    required this.creatorId,
    this.description,
    this.postImages,
    this.postComments,
    this.likedUsers,
    required this.createdTime,
    this.updatedTime,
  });

  factory PostData.fromMap(Map<String, dynamic> json) {
    return PostData._(
      id: json['id'],
      creatorId: json['creatorId'],
      description: json['description'],
      postImages: json['postImages'] != null
          ? List<PostImageData>.from(
              json['postImages'].map((x) => PostImageData.fromMap(x)))
          : null,
      postComments: json['postComments'] != null
          ? List<CommentData>.from(
              json['postComments'].map((x) => CommentData.fromJson(x)))
          : null,
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
    data['creatorId'] = this.creatorId;
    data['description'] = this.description;
    if (this.postImages != null) {
      data['postImages'] = this
          .postImages!
          .map((image) => image is Map<String, dynamic> ? image : image.toMap())
          .toList();
    }
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers;
    }
    data['createdTime'] = this.createdTime;
    data['updatedTime'] = this.updatedTime;
    return data;
  }

  Map<String, dynamic> toFirebaseMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creatorId'] = this.creatorId;
    data['description'] = this.description;
    if (this.postImages != null) {
      data['postImages'] = this
          .postImages!
          .map((image) =>
              image is Map<String, dynamic> ? image : image.toFirebaseMap())
          .toList();
    }
    if (this.postComments != null) {
      data['postComments'] = this
          .postComments!
          .map((comment) =>
              comment is Map<String, dynamic> ? comment : comment.toMap())
          .toList();
    }
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers;
    }
    data['createdTime'] =
        this.createdTime != null ? Timestamp.fromDate(this.createdTime!) : null;
    data['updatedTime'] =
        this.updatedTime != null ? Timestamp.fromDate(this.updatedTime!) : null;
    return data;
  }

  PostData copyWith({
    String? id,
    String? creatorId,
    String? description,
    List<PostImageData>? postImages,
    List<CommentData>? postComments,
    List<String?>? likedUsers,
    bool? isFavourite,
    DateTime? createdTime,
    DateTime? updatedTime,
  }) {
    return PostData._(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      description: description ?? this.description,
      postImages: postImages ?? this.postImages,
      postComments: postComments ?? this.postComments,
      likedUsers: likedUsers ?? this.likedUsers,
      createdTime: createdTime ?? this.createdTime,
      updatedTime: updatedTime ?? this.updatedTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          creatorId == other.creatorId &&
          createdTime == other.createdTime;

  @override
  int get hashCode => id.hashCode ^ creatorId.hashCode ^ createdTime.hashCode;
}

class PostImageData {
  final String? id;
  final String? postId;
  late final String? url;
  final String? path;
  bool uploaded = true;

  PostImageData({
    this.id,
    this.postId,
    this.url,
    this.path,
    this.uploaded = true,
  });

  factory PostImageData.fromMap(Map<String, dynamic> json) {
    return PostImageData(
      id: json['id'],
      postId: json['postId'],
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['url'] = this.url;
    data['path'] = this.path;
    return data;
  }

  Map<String, dynamic> toFirebaseMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['url'] = this.url;
    return data;
  }

  PostImageData copyWith({
    String? id,
    String? postId,
    String? url,
    String? path,
    bool uploaded = true,
  }) {
    return PostImageData(
      id: id ?? id,
      postId: postId ?? postId,
      url: url ?? url,
      path: path ?? path,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostImageData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class PostDataField {
  static const String id = 'id';
  static const String description = 'description';
  static const String postImages = 'postImages';
  static const String isFavourite = 'isFavourite';
  static const String createdTime = 'createdTime';
  static const String updatedTime = 'updatedTime';
}

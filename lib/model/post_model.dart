class PostData {
  final String? id;
  final String? creatorId;
  final String? description;
  final List<PostImageData>? postImages;
  final List<String?>? likedUsers;
  bool? isFavourite;
  final DateTime? createdTime;
  final DateTime? updatedTime;

  PostData({
    this.id,
    this.creatorId,
    this.description,
    this.postImages,
    this.likedUsers,
    this.createdTime,
    this.updatedTime,
  });

  PostData.create({
    this.id,
    required this.creatorId,
    required this.description,
    this.postImages,
    this.likedUsers,
    required this.createdTime,
    this.updatedTime,
  });

  PostData.update({
    required this.id,
    required this.creatorId,
    required this.description,
    this.postImages,
    this.likedUsers,
    required this.createdTime,
    required this.updatedTime,
  });

  PostData.delete({
    required this.id,
    required this.creatorId,
    this.description,
    this.postImages,
    this.likedUsers,
    required this.createdTime,
    this.updatedTime,
  });

  factory PostData.fromMap(Map<String, dynamic> json) {
    return PostData(
      id: json['id'],
      creatorId: json['creatorId'],
      description: json['description'],
      postImages: json['postImages'] != null
          ? List<PostImageData>.from(
              json['postImages'].map((x) => PostImageData.fromMap(x)))
          : null,
      likedUsers: json['likedUsers'] != null
          ? List<String?>.from(json['likedUsers'])
          : null,
      createdTime: json['createdTime'],
      updatedTime: json['updatedTime'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['creatorId'] = this.creatorId;
    data['description'] = this.description;
    if (this.postImages != null) {
      data['postImages'] =
          this.postImages!.map((image) => image.toMap()).toList();
    }
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers;
    }
    data['createdTime'] = this.createdTime;
    data['updatedTime'] = this.updatedTime;
    return data;
  }

  PostData copyWith({
    String? id,
    String? description,
    List<PostImageData>? postImages,
    List<String?>? likedUsers,
    bool? isFavourite,
    DateTime? createdTime,
    DateTime? updatedTime,
  }) {
    return PostData(
      id: id ?? this.id,
      description: description ?? this.description,
      postImages: postImages ?? this.postImages,
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
  final String? url;
  final String? path;
  bool uploaded = true;

  PostImageData({
    this.id,
    this.url,
    this.path,
    this.uploaded = true,
  });

  factory PostImageData.fromMap(Map<String, dynamic> json) {
    return PostImageData(
      id: json['id'],
      url: json['url'],
      path: json['path'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['path'] = this.path;
    return data;
  }

  Map<String, dynamic> toFirebaseMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
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

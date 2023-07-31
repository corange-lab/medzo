class CommentData {
  String? id;
  String? content;
  List<String?>? likedUsers;
  DateTime? createdTime;
  DateTime? updatedTime;

  CommentData({
    this.id,
    required this.content,
    this.likedUsers,
    this.createdTime,
    this.updatedTime,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      id: json['id'],
      content: json['content'],
      likedUsers: json['likedUsers'] != null
          ? List<String?>.from(json['likedUsers'])
          : null,
      createdTime: json['createdTime'] != null
          ? DateTime.parse(json['createdTime'])
          : null,
      updatedTime: json['updatedTime'] != null
          ? DateTime.parse(json['updatedTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    if (this.likedUsers != null) {
      data['likedUsers'] = this.likedUsers;
    }
    if (this.createdTime != null) {
      data['createdTime'] = this.createdTime!.toIso8601String();
    }
    if (this.updatedTime != null) {
      data['updatedTime'] = this.updatedTime!.toIso8601String();
    }
    return data;
  }

  // Named constructor "create"
  factory CommentData.create({
    required String content,
    DateTime? createdTime,
  }) {
    return CommentData(
      content: content,
      createdTime: createdTime,
    );
  }
}

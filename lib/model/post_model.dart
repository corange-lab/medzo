class PostModel {
  List<String>? postImages;
  String? description;
  String? id;
  bool? isFavourite;
  String? createdTime;
  String? updatedTime;

  PostModel(
      {this.postImages,
      this.description,
      this.id,
      this.isFavourite,
      this.createdTime,
      this.updatedTime});

  PostModel.fromMap(Map<String, dynamic> json) {
    postImages = json['postImages'].cast<String>();
    description = json['description'];
    id = json['id'];
    isFavourite = json['isFavourite'];
    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postImages'] = this.postImages;
    data['description'] = this.description;
    data['id'] = this.id;
    data['isFavourite'] = this.isFavourite;
    data['createdTime'] = this.createdTime;
    data['updatedTime'] = this.updatedTime;
    return data;
  }
}

class PostModelField {
  static const String id = 'id';
  static const String description = 'description';
  static const String postImages = 'postImages';
  static const String isFavourite = 'isFavourite';
  static const String createdTime = 'createdTime';
  static const String updatedTime = 'updatedTime';
}

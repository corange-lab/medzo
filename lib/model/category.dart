class CategoryDataModel {
  String? id;
  String? name;
  String? image;

  CategoryDataModel({this.id, this.name, this.image});

  CategoryDataModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

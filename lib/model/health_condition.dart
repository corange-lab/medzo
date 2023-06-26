class HealthCondition {
  int? id;
  String? title;
  String? desc;

  HealthCondition({this.id, this.title, this.desc,});

  HealthCondition.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }
}

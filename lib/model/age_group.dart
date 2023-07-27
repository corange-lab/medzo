class AgeGroup {
  int? age;

  AgeGroup({
    this.age,
  });

  AgeGroup.fromMap(Map<String, dynamic> json) {
    age = json['age'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['age'] = age;
    return data;
  }
}

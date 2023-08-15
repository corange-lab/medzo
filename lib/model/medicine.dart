class Medicine {
  String? id;
  String? medicineName;
  String? shortDescription;
  String? categoryId;
  String? genericName;
  String? about;
  String? warning;
  String? medicationsAndSubstances;

  Medicine(
      {this.id,
      this.medicineName,
      this.shortDescription,
      this.categoryId,
      this.genericName,
      this.about,
      this.warning,
      this.medicationsAndSubstances});

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineName = map['medicineName'];
    shortDescription = map['shortDescription'];
    categoryId = map['categoryId'];
    genericName = map['genericName'];
    about = map['about'];
    warning = map['warning'];
    medicationsAndSubstances = map['medicationsAndSubstances'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineName'] = medicineName;
    data['shortDescription'] = shortDescription;
    data['categoryId'] = categoryId;
    data['genericName'] = genericName;
    data['about'] = about;
    data['warning'] = warning;
    data['medicationsAndSubstances'] = medicationsAndSubstances;
    return data;
  }
}

class Medicine {
  String? id;
  String? genericName;
  String? shortDescription;
  String? categoryId;
  String? medicineName;
  String? about;
  String? ratings;
  String? warning;
  // String? medicationsAndSubstances;

  Medicine({
    this.id,
    this.genericName,
    this.shortDescription,
    this.categoryId,
    this.medicineName,
    this.about,
    this.warning,
    this.ratings,
    // this.medicationsAndSubstances
  });

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    genericName = map['genericName'];
    shortDescription = map['shortDescription'];
    categoryId = map['categoryId'];
    medicineName = map['medicineName'];
    about = map['about'];
    warning = map['warning'];
    ratings = map['ratings'];
    // medicationsAndSubstances = map['medicationsAndSubstances'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['genericName'] = genericName;
    data['shortDescription'] = shortDescription;
    data['categoryId'] = categoryId;
    data['medicineName'] = medicineName;
    data['about'] = about;
    data['warning'] = warning;
    data['ratings'] = ratings;
    // data['medicationsAndSubstances'] = medicationsAndSubstances;
    return data;
  }
}

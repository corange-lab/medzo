class Medicine {
  String? id;
  String? medicineName;
  String? shortDescription;
  String? image;
  String? categoryId;
  String? drugType;
  String? about;
  String? warning;
  String? factorsOrConditions;
  String? medicationsAndSubstances;

  Medicine(
      {this.id,
      this.medicineName,
      this.shortDescription,
      this.image,
      this.categoryId,
      this.drugType,
      this.about,
      this.warning,
      this.factorsOrConditions,
      this.medicationsAndSubstances});

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineName = map['medicineName'];
    shortDescription = map['shortDescription'];
    image = map['image'];
    categoryId = map['categoryId'];
    drugType = map['drugType'];
    about = map['about'];
    warning = map['warning'];
    factorsOrConditions = map['factorsOrConditions'];
    medicationsAndSubstances = map['medicationsAndSubstances'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineName'] = medicineName;
    data['shortDescription'] = shortDescription;
    data['image'] = image;
    data['categoryId'] = categoryId;
    data['drugType'] = drugType;
    data['about'] = about;
    data['warning'] = warning;
    data['factorsOrConditions'] = factorsOrConditions;
    data['medicationsAndSubstances'] = medicationsAndSubstances;
    return data;
  }
}

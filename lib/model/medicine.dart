class Medicine {
  String? id;
  String? genericName;
  String? shortDescription;
  String? categoryId;
  String? brandName;
  String? about;
  String? ratings;
  String? warnings;
  String? medicationsAndSubstances;
  String? drugDrugInteractions;

  Medicine({this.id,
    this.genericName,
    this.shortDescription,
    this.categoryId,
    this.brandName,
    this.about,
    this.warnings,
    this.ratings,
    this.medicationsAndSubstances,
    this.drugDrugInteractions
  });

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    genericName = map['genericName'];
    shortDescription = map['shortDescription'];
    categoryId = map['categoryId'];
    brandName = map['brandName'];
    about = map['about'];
    warnings = map['warnings'];
    ratings = map['ratings'];
    medicationsAndSubstances = map['medicationsAndSubstances'];
    drugDrugInteractions = map['drugDrugInteractions'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['genericName'] = genericName;
    data['shortDescription'] = shortDescription;
    data['categoryId'] = categoryId;
    data['brandName'] = brandName;
    data['about'] = about;
    data['warnings'] = warnings;
    data['ratings'] = ratings;
    data['medicationsAndSubstances'] = medicationsAndSubstances;
    data['drugDrugInteractions'] = drugDrugInteractions;
    return data;
  }
}

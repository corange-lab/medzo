class Medicine {
  String? id;
  String? genericName;
  String? shortDescription;
  String? categoryId;
  String? brandName;
  String? link;
  String? about;
  String? ratings;
  String? warnings;
  String? medicationsAndSubstances;
  String? drugDrugInteractions;

  Medicine(
      {this.id,
      this.genericName,
      this.shortDescription,
      this.categoryId,
      this.brandName,
      this.link,
      this.about,
      this.warnings,
      this.ratings,
      this.medicationsAndSubstances,
      this.drugDrugInteractions});

  Medicine.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    genericName = map['genericName'];
    shortDescription = map['shortDescription'];
    categoryId = map['categoryId'];
    brandName = map['brandName'];
    link = map['link'];
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
    data['link'] = link;
    data['about'] = about;
    data['warnings'] = warnings;
    data['ratings'] = ratings;
    data['medicationsAndSubstances'] = medicationsAndSubstances;
    data['drugDrugInteractions'] = drugDrugInteractions;
    return data;
  }
}

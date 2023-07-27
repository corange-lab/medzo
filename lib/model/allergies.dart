class Allergies {
  bool? haveAllergies;
  String? currentAllergies;
  String? howSeverAllergies;

  Allergies({
    this.haveAllergies,
    this.currentAllergies,
    this.howSeverAllergies,
  });

  Allergies.fromMap(Map<String, dynamic> json) {
    haveAllergies = json['haveAllergies'];
    currentAllergies = json['currentAllergies'];
    howSeverAllergies = json['howSeverAllergies'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['haveAllergies'] = haveAllergies;
    data['currentAllergies'] = currentAllergies;
    data['howSeverAllergies'] = howSeverAllergies;
    return data;
  }
}

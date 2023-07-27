class CurrentMedication {
  bool? takingMedicine;
  String? currentTakingMedicine;
  String? durationTakingMedicine;

  CurrentMedication({
    this.takingMedicine,
    this.currentTakingMedicine,
    this.durationTakingMedicine,
  });

  CurrentMedication.fromMap(Map<String, dynamic> json) {
    takingMedicine = json['takingMedicine'];
    currentTakingMedicine = json['currentTakingMedicine'];
    durationTakingMedicine = json['durationTakingMedicine'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['takingMedicine'] = takingMedicine;
    data['currentTakingMedicine'] = currentTakingMedicine;
    data['durationTakingMedicine'] = durationTakingMedicine;
    return data;
  }
}

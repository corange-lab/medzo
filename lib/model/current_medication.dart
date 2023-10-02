class CurrentMedication {
  bool? takingMedicine;
  List<String>? currentTakingMedicine;
  var durationTakingMedicine;

  CurrentMedication({
    this.takingMedicine,
    this.currentTakingMedicine,
    this.durationTakingMedicine,
  });

  CurrentMedication.fromMap(Map<String, dynamic> json) {
    takingMedicine = json['takingMedicine'];
    currentTakingMedicine = json['currentTakingMedicine'] != null && json['currentTakingMedicine'] is List
        ? List<String>.from(json['currentTakingMedicine'])
        : null;
    durationTakingMedicine = json['durationTakingMedicine'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['takingMedicine'] = takingMedicine;
    if (this.currentTakingMedicine != null) {
      data['currentTakingMedicine'] = this.currentTakingMedicine;
    }
    data['durationTakingMedicine'] = durationTakingMedicine;
    return data;
  }
}

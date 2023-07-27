class HealthCondition {
  bool? doesHealthCondition;
  String? healthCondition;
  String? healthConditionDuration;

  HealthCondition({
    this.doesHealthCondition,
    this.healthCondition,
    this.healthConditionDuration,
  });

  HealthCondition.fromMap(Map<String, dynamic> json) {
    doesHealthCondition = json['doesHealthCondition'];
    healthCondition = json['healthCondition'];
    healthConditionDuration = json['healthConditionDuration'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doesHealthCondition'] = doesHealthCondition;
    data['healthCondition'] = healthCondition;
    data['healthConditionDuration'] = healthConditionDuration;
    return data;
  }
}

class GeneralResponse {
  dynamic status;
  String? details;

  GeneralResponse({this.status, this.details});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['details'] = details;
    return data;
  }
}

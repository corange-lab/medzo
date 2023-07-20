class UserResponse {
  dynamic data;
  String? message;

  UserResponse({this.data, this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}
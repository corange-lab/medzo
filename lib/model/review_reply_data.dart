import 'package:medzo/utils/firebase_utils.dart';

class ReviewReplyModel {
  String? id;
  String? userId;
  String? reply;
  DateTime? repliedTime;

  ReviewReplyModel({this.id, this.userId, this.reply, this.repliedTime});

  ReviewReplyModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    userId = map["userId"];
    reply = map["reply"];
    repliedTime = map['repliedTime'] != null
        ? FirebaseUtils.timestampToDateTime(map['repliedTime'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["userId"] = userId;
    data["reply"] = reply;
    if (this.repliedTime != null) {
      data['repliedTime'] = this.repliedTime;
    }
    return data;
  }
}

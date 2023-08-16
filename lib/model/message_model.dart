class messageModel {
  String? messageId;
  String? sender;
  String? message;
  bool? isSeen;
  DateTime? createdTime;

  messageModel(
      {this.messageId,
      this.sender,
      this.message,
      this.isSeen,
      this.createdTime});

  messageModel.fromMap(Map<String,dynamic> map){
    messageId = map['messageId'];
    sender = map['sender'];
    message = map['message'];
    isSeen = map['isSeen'];
    createdTime = map['createdTime'].toDate();
  }

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['messageId'] = messageId;
    data['sender'] = sender;
    data['message'] = message;
    data['isSeen'] = isSeen;
    data['createdTime'] = createdTime;
    return data;
  }

}

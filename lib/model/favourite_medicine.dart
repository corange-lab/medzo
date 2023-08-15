import 'package:medzo/utils/firebase_utils.dart';

class FavouriteMedicine {
  String? userId;
  String? medicineId;
  DateTime? timeStamp;

  FavouriteMedicine({this.userId, this.medicineId, this.timeStamp});

  FavouriteMedicine.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    medicineId = map['medicineId'];
    timeStamp = map['timeStamp'] != null
        ? FirebaseUtils.timestampToDateTime(map['timeStamp'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['medicineId'] = this.medicineId;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}

import 'package:medzo/utils/firebase_utils.dart';

class Review {
  String? id;
  String? medicineId;
  String? userId;
  double? rating;
  String? review;
  DateTime? createdTime;

  Review(
      {this.id,
      this.medicineId,
      this.userId,
      this.rating,
      this.review,
      this.createdTime});

  Review.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineId = map['medicineId'];
    userId = map['userId'];
    rating = map['rating'];
    review = map['review'];
    map['createdTime'] != null
        ? FirebaseUtils.timestampToDateTime(map['createdTime'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineId'] = this.medicineId;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['createdTime'] = this.createdTime;
    return data;
  }
}

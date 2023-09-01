import 'package:medzo/model/review_reply_data.dart';
import 'package:medzo/utils/firebase_utils.dart';

class ReviewDataModel {
  String? id;
  String? medicineId;
  String? userId;
  double? rating;
  String? review;
  List<ReviewReplyModel>? reviewReplies;
  DateTime? createdTime;

  ReviewDataModel(
      {this.id,
      this.medicineId,
      this.userId,
      this.rating,
      this.review,
      this.reviewReplies,
      this.createdTime});

  ReviewDataModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineId = map['medicineId'];
    userId = map['userId'];
    rating = map['rating'];
    review = map['review'];
    reviewReplies = map['reviewReplies'] != null
        ? List<ReviewReplyModel>.from(
            map['reviewReplies'].map((x) => ReviewReplyModel.fromMap(x)))
        : null;
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

  Map<String, dynamic> toFirebaseMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineId'] = this.medicineId;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    if (this.reviewReplies != null) {
      data['reviewReplies'] = this
          .reviewReplies!
          .map((reply) => reply is Map<String, dynamic> ? reply : reply.toMap())
          .toList();
    }
    data['createdTime'] = this.createdTime;
    return data;
  }

  ReviewDataModel copyWith({
    String? id,
    String? medicineId,
    String? userId,
    double? rating,
    String? review,
    List<ReviewReplyModel>? reviewReplies,
    DateTime? createdTime,
  }) {
    return ReviewDataModel(
      id: id ?? this.id,
      medicineId : medicineId ?? this.medicineId,
      userId : userId ?? this.userId,
      rating : rating ?? this.rating,
      review : review ?? this.review,
      reviewReplies : reviewReplies ?? this.reviewReplies,
      createdTime : createdTime ?? this.createdTime,
    );
  }
}

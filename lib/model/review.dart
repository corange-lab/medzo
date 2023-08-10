class Review {
  String? id;
  String? medicineId;
  String? userId;
  double? rating;
  String? review;

  Review({this.id, this.medicineId, this.userId, this.rating, this.review});

  Review.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    medicineId = map['medicineId'];
    userId = map['userId'];
    rating = map['rating'];
    review = map['review'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['medicineId'] = medicineId;
    data['userId'] = userId;
    data['rating'] = rating;
    data['review'] = review;
    return data;
  }
}

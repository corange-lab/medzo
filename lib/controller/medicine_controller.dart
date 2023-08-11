import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/model/review.dart';

class MedicineController extends GetxController {
  TextEditingController reviewText = TextEditingController();
  double rating = 0.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMedicine();
  }

  final CollectionReference reviewRef =
      FirebaseFirestore.instance.collection('reviews');

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');

  Stream<QuerySnapshot<Object?>> fetchMedicine() {
    return medicineRef.get().asStream();
  }

  Stream<List<Review>> getReview(String medicineId) {
    var data = FirebaseFirestore.instance
        .collection('reviews')
        .where('medicineId', isEqualTo: medicineId)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Review.fromMap(e.data());
      }).toList();
    });
    return data;
  }
}

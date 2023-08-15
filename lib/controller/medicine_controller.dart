import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/review.dart';
import 'package:medzo/model/user_model.dart';

class MedicineController extends GetxController {
  TextEditingController reviewText = TextEditingController();
  double rating = 0.0;

  List<dynamic> currentMedicines = [];
  RxList FavouriteMedicine = [].obs;

  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  AllUserController userController = Get.put(AllUserController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMedicine();
    fetchCategory();
  }

  final CollectionReference reviewRef =
      FirebaseFirestore.instance.collection('reviews');

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');

  final CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference favouriteRef =
      FirebaseFirestore.instance.collection('favourites');

  Stream<List<Medicine>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<Category_Model>> fetchCategory() {
    var data = categoryRef.snapshots().map((event) {
      return event.docs.map((e) {
        return Category_Model.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<Medicine>> getCategoryWiseMedicine(String categoryId) {
    var data = medicineRef
        .where('categoryId', isEqualTo: categoryId)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<Review>> getReview(String medicineId) {
    var data = FirebaseFirestore.instance
        .collection('reviews')
        .where('medicineId', isEqualTo: medicineId)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Review.fromMap(e.data());
      }).toList();
    });
    return data;
  }

  UserModel findUser(String userId) {
    return userController.findSingleUserFromAllUser(userId);
  }

  String findMedicineRating(List<double> ratingList) {
    double sumRating = 0;
    for (var i in ratingList) {
      sumRating += i;
    }

    double averageRating = sumRating / ratingList.length;
    return averageRating.toStringAsFixed(1);
  }

  Future<bool> isMedicineFavourite(String medicineId) async {
    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      List<dynamic> currentMedicines = docSnapshot.data()?['medicine'] ?? [];

      bool isFavourite =
          currentMedicines.any((item) => item['medicineId'] == medicineId);

      return isFavourite;
    } else {
      return false;
    }
  }

  Future<void> isFavouriteMedicine(String medicineId) async {
    bool isFavourite = await isMedicineFavourite(medicineId);

    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    Map<String, dynamic> medicineData = {
      "medicineId": medicineId,
      "timeStamp": DateTime.now()
    };

    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      currentMedicines = docSnapshot.data()?['medicine'] ?? [];
      if (!isFavourite) {
        FavouriteMedicine.add(medicineId);
        currentMedicines.add(medicineData);
      } else {
        isNotFavouriteMedicine(medicineId);
      }
      userFavouritesDoc.update({'medicine': currentMedicines});
    } else {
      userFavouritesDoc.set({
        'medicine': [medicineData]
      });
    }
    ;
  }

  Future<void> isNotFavouriteMedicine(String medicineId) async {
    currentMedicines.remove(medicineId);
    FavouriteMedicine.remove(medicineId);
    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      currentMedicines = docSnapshot.data()?['medicine'] ?? [];

      currentMedicines.removeWhere((item) => item['medicineId'] == medicineId);

      userFavouritesDoc.update({'medicine': currentMedicines});
    } else {
      print("No favourites found for user $currentUser");
    }
  }
}

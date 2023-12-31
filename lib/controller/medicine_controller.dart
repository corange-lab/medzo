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
  RxList<String> favouriteMedicines = <String>[].obs;

  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  AllUserController userController = Get.put(AllUserController());

  RxString updatingId = ''.obs;

  List<Medicine> allMedicines = [];

  @override
  void onInit() {
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

  Stream<List<Medicine>> fetchPopularMedicine() {
    var data = medicineRef.limit(3).snapshots().map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<Medicine>> fetchFavouriteMedicine() {
    if (favouriteMedicines.isEmpty) {
      return Stream.empty();
    }
    var data = medicineRef
        .where(
          'id',
          whereIn: favouriteMedicines,
        )
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<CategoryDataModel>> fetchCategory() {
    var data = categoryRef.snapshots().map((event) {
      return event.docs.map((e) {
        return CategoryDataModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Stream<List<Medicine>> getCategoryWiseMedicine(String categoryId) {
    var data = medicineRef
        .where('categoryId', isEqualTo: categoryId.trim())
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

  String findMedicineRating(List<Review> reviewList) {
    List<double> ratingList = [];
    for (var i = 0; i < reviewList.length; i++) {
      ratingList.add(reviewList[i].rating!);
    }

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

  Future<void> addFavouriteMedicine(String medicineId) async {
    bool isFavourite = await isMedicineFavourite(medicineId);

    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    Map<String, dynamic> medicineData = {
      "medicineId": medicineId,
      "timeStamp": DateTime.now()
    };
    updatingId.value = medicineId;
    update([medicineId + 'update']);
    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      currentMedicines = docSnapshot.data()?['medicine'] ?? [];
      if (!isFavourite) {
        favouriteMedicines.add(medicineId);
        currentMedicines.add(medicineData);

        userFavouritesDoc.update({'medicine': currentMedicines});
        updatingId.value = '';
        update([medicineId, medicineId + 'update']);
      } else {
        removeFavouriteMedicine(medicineId);
      }
    } else {
      userFavouritesDoc.set({
        'medicine': [medicineData]
      });
      update([medicineId]);
    }
  }

  Future<void> removeFavouriteMedicine(String medicineId) async {
    currentMedicines.removeWhere((item) => item['medicineId'] == medicineId);
    favouriteMedicines.remove(medicineId);
    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      currentMedicines = docSnapshot.data()?['medicine'] ?? [];

      currentMedicines.removeWhere((item) => item['medicineId'] == medicineId);

      userFavouritesDoc.update({'medicine': currentMedicines});
      updatingId.value = '';
      update([medicineId, medicineId + 'update']);
      return;
    } else {
      print("No favourites found for user $currentUser");
      return;
    }
  }

  bool isFavourite(String? id) {
    if (id == null) {
      return false;
    }
    return favouriteMedicines.contains(id);
  }

  Future<List<Medicine>> getPopularMedicinesByReviews(
      {double minReviews = 5}) async {
    final QuerySnapshot reviewSnapshot = await reviewRef.get();

    final Map<String, double> medicineReviewCounts = {};

    reviewSnapshot.docs.forEach((reviewDoc) {
      final String medicineId = reviewDoc['medicineId'];

      if (!medicineReviewCounts.containsKey(medicineId)) {
        medicineReviewCounts[medicineId] = 1;
      } else {
        medicineReviewCounts[medicineId] =
            medicineReviewCounts[medicineId]! + 1;
      }
    });

    final List<String> popularMedicineIds = [];

    medicineReviewCounts.forEach((medicineId, reviewCount) {
      if (reviewCount >= minReviews) {
        popularMedicineIds.add(medicineId);
      }
    });
    // print('allMedicines.length ${allMedicines.length}');
    final List<Medicine> popularMedicines = allMedicines
        .where((medicine) => popularMedicineIds.contains(medicine.id))
        .toList();
    return popularMedicines;
  }
}

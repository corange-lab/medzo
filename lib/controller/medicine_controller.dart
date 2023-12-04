import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/review_data_model.dart';
import 'package:medzo/model/review_reply_data.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/url_launch.dart';

class MedicineController extends GetxController {
  TextEditingController reviewText = TextEditingController();
  TextEditingController searchMedicineText = TextEditingController();
  double rating = 0.0;

  List<dynamic> currentMedicines = [];
  RxList<String> favouriteMedicines = <String>[].obs;

  String currentUser = FirebaseAuth.instance.currentUser!.uid;

  AllUserController userController = Get.put(AllUserController());

  TextEditingController replyController = TextEditingController();
  final FocusNode replyFocusNode = FocusNode();

  RxString updatingId = ''.obs;

  List<Medicine> allMedicines = [];

  ReviewDataModel? currentReviewData;

  String? categoryId;

  RxList<Medicine> medicines = <Medicine>[].obs;

  List searchsubtitleList = [
    "in allergies",
    "in cancer treatment",
    "in antibiotics",
    "in cardiovascular",
    "in weightless"
  ];
  List searchIcons = [
    SvgIcon.virus,
    SvgIcon.first_aid,
    SvgIcon.virus,
    SvgIcon.heartbeat,
    SvgIcon.person_run
  ];

  String loggedInUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    fetchMedicine();
    fetchMedicineList();
    fetchCategory();
    isMedicineFavourite();
    fetchMedicineId();
  }

  final CollectionReference reviewRef =
      FirebaseFirestore.instance.collection('reviews');

  final CollectionReference medicineRef =
      FirebaseFirestore.instance.collection('medicines');

  final CollectionReference categoryRef =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference favouriteRef =
      FirebaseFirestore.instance.collection('favourites');

  void searchMedicineByName(String medicineName) {
    try {
      medicines.clear();
      // medicineRef
      //     .where("genericName", isGreaterThanOrEqualTo: medicineName)
      //     .where("genericName", isLessThan: medicineName + '\uf8ff')
      //     .get()
      //     .then((snapshot) {
      //   var _medicines = snapshot.docs
      //       .map((doc) => Medicine.fromMap(doc.data() as Map<String, dynamic>))
      //       .toList();
      //   medicines.addAll(_medicines);
      //   // update();
      // });
      medicineRef
          .where("brandName", isGreaterThanOrEqualTo: medicineName)
          .where("brandName", isLessThan: medicineName + '\uf8ff')
          .get()
          .then((snapshot) {
        var _medicines = snapshot.docs
            .map((doc) => Medicine.fromMap(doc.data() as Map<String, dynamic>))
            .toList();

        medicines.addAll(_medicines);
      });
    } catch (e) {
      print(e);
    }
  }

  // Future<CategoryDataModel> fetchCategoryFromId(String categoryId) async {
  //   DocumentSnapshot documentSnapshot = await categoryRef.doc(categoryId).get();
  //
  //   CategoryDataModel category = CategoryDataModel.fromMap(
  //       documentSnapshot.data() as Map<String, dynamic>);
  //
  //   return category;
  // }

  Future<CategoryDataModel> fetchCategoryFromId(String categoryId) {
    Completer<CategoryDataModel> completer = Completer();

    categoryRef.doc(categoryId).get().then((documentSnapshot) {
      completer.complete(CategoryDataModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>));
    });

    return completer.future; // This line still returns a Future!
  }

  Stream<List<Medicine>> fetchMedicine() {
    var data = medicineRef.snapshots().map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Future<List<Medicine>> fetchMedicineList() async {
    QuerySnapshot snapshot = await medicineRef.get();
    return snapshot.docs.map((doc) {
      return Medicine.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Stream<List<Medicine>> fetchHomePopularMedicine() {
    var data = medicineRef.limit(3).snapshots().map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  Future<List<String>> fetchMedicineId() async {
    DocumentSnapshot data = await favouriteRef.doc(currentUser).get();

    List<String> medicineIds = [];

    if (data.exists) {
      List<Map<String, dynamic>> medicines =
          List<Map<String, dynamic>>.from(data['medicine'] ?? []);
      for (var medicine in medicines) {
        medicineIds.add(medicine['medicineId']);
      }
    }
    favouriteMedicines = medicineIds.obs;

    return medicineIds;
  }

  Stream<List<Medicine>> fetchPopularMedicine() {
    var data = medicineRef
        .where('ratings', isGreaterThanOrEqualTo: "3.5")
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Medicine.fromMap(e.data() as Map<String, dynamic>);
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

  Stream<List<ReviewDataModel>> getReview(String medicineId) {
    var data = FirebaseFirestore.instance
        .collection('reviews')
        .where('medicineId', isEqualTo: medicineId)
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return ReviewDataModel.fromMap(e.data());
      }).toList();
    });
    return data;
  }

  UserModel findUser(String userId) {
    return userController.findSingleUserFromAllUser(userId);
  }

  String countMedicineRating(List<ReviewDataModel> reviewList) {
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

  Future<void> isMedicineFavourite() async {
    final userFavouritesDoc =
        FirebaseFirestore.instance.collection('favourites').doc(currentUser);

    final docSnapshot = await userFavouritesDoc.get();

    if (docSnapshot.exists) {
      currentMedicines = docSnapshot.data()?['medicine'] ?? [];
    } else {
      currentMedicines = [];
    }
    update();
  }

  Future<void> addFavouriteMedicine(String medicineId) async {
    bool isFavourite =
        currentMedicines.any((item) => item['medicineId'] == medicineId);

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
    return currentMedicines.any((medicine) => medicine['medicineId'] == id);
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

  Future<ReviewDataModel?> addReply() async {
    var value = await reviewRef.doc(currentReviewData!.id).get();

    if (value.data() == null) {
      return null;
    }

    currentReviewData =
        ReviewDataModel.fromMap(value.data() as Map<String, dynamic>);

    String repliedId = reviewRef.doc().id;

    currentReviewData = currentReviewData!.copyWith(reviewReplies: [
      ...currentReviewData!.reviewReplies ?? [],
      ReviewReplyModel(
          id: repliedId,
          userId: currentUser,
          reply: replyController.text.trim(),
          repliedTime: DateTime.now())
    ]);

    replyController.clear();
    await reviewRef
        .doc(currentReviewData!.id)
        .set(currentReviewData!.toFirebaseMap(), SetOptions(merge: true));

    replyFocusNode.unfocus();
    return currentReviewData!;
  }

  Future<void> deleteReview(ReviewDataModel reviewData) async {
    return await reviewRef.doc(reviewData.id).delete();
  }

  Future<void> deleteReviewReply(
      ReviewDataModel reviewDataModel, ReviewReplyModel replyModel) async {
    // reviewDataModel.reviewReplies!.remove(replyModel.id);
    print("Before removal: ${reviewDataModel.reviewReplies!.length}");

    reviewDataModel.reviewReplies!
        .removeWhere((reply) => reply.id == replyModel.id);

    print("After removal: ${reviewDataModel.reviewReplies!.length}");

    return reviewRef
        .doc(reviewDataModel.id)
        .set(reviewDataModel.toFirebaseMap(), SetOptions(merge: true));
  }

  // check whether my ReviewDataModel has been upvoted by current user or not
  bool isVoted(ReviewDataModel reviewData, {required bool forUpvote}) {
    if (forUpvote) {
      if (reviewData.upvoteUsers != null &&
          reviewData.upvoteUsers!.isNotEmpty) {
        return reviewData.upvoteUsers!.contains(userController.loggedInUser);
      }
    } else {
      if (reviewData.downvoteUsers != null &&
          reviewData.downvoteUsers!.isNotEmpty) {
        return reviewData.downvoteUsers!.contains(userController.loggedInUser);
      }
    }
    return false;
  }

  Future<void> addUpvote(
    ReviewDataModel reviewData, {
    required bool isForUpvote,
  }) async {
    if (reviewData.upvoteUsers == null) {
      reviewData.upvoteUsers = [];
    }
    if (reviewData.downvoteUsers == null) {
      reviewData.downvoteUsers = [];
    }

    if (isForUpvote) {
      if (reviewData.upvoteUsers!.contains(userController.loggedInUser)) {
        reviewData.upvoteUsers!.remove(userController.loggedInUser);
      } else {
        if (reviewData.downvoteUsers!.contains(userController.loggedInUser)) {
          reviewData.downvoteUsers!.remove(userController.loggedInUser);
        }

        reviewData.upvoteUsers!.add(userController.loggedInUser);
      }
    } else {
      if (reviewData.downvoteUsers!.contains(userController.loggedInUser)) {
        reviewData.downvoteUsers!.remove(userController.loggedInUser);
      } else {
        if (reviewData.upvoteUsers!.contains(userController.loggedInUser)) {
          reviewData.upvoteUsers!.remove(userController.loggedInUser);
        }
        reviewData.downvoteUsers!.add(userController.loggedInUser);
      }
    }
    update();
    return reviewRef
        .doc(reviewData.id)
        .set(reviewData.toFirebaseMap(), SetOptions(merge: true));
  }

  // check whether my ReviewReplyModel has been upvoted by current user or not
  bool isReplyVoted(ReviewReplyModel reviewData, {required bool forUpvote}) {
    if (forUpvote) {
      if (reviewData.upvoteUsers != null &&
          reviewData.upvoteUsers!.isNotEmpty) {
        return reviewData.upvoteUsers!.contains(userController.loggedInUser);
      }
    } else {
      if (reviewData.downvoteUsers != null &&
          reviewData.downvoteUsers!.isNotEmpty) {
        return reviewData.downvoteUsers!.contains(userController.loggedInUser);
      }
    }
    return false;
  }

  Future<void> addReplyUpvote(
    ReviewReplyModel reviewData, {
    required bool isForUpvote,
  }) async {
    if (reviewData.upvoteUsers == null) {
      reviewData.upvoteUsers = [];
    }
    if (reviewData.downvoteUsers == null) {
      reviewData.downvoteUsers = [];
    }

    if (isForUpvote) {
      if (reviewData.upvoteUsers!.contains(userController.loggedInUser)) {
        reviewData.upvoteUsers!.remove(userController.loggedInUser);
      } else {
        if (reviewData.downvoteUsers!.contains(userController.loggedInUser)) {
          reviewData.downvoteUsers!.remove(userController.loggedInUser);
        }

        reviewData.upvoteUsers!.add(userController.loggedInUser);
      }
    } else {
      if (reviewData.downvoteUsers!.contains(userController.loggedInUser)) {
        reviewData.downvoteUsers!.remove(userController.loggedInUser);
      } else {
        if (reviewData.upvoteUsers!.contains(userController.loggedInUser)) {
          reviewData.upvoteUsers!.remove(userController.loggedInUser);
        }
        reviewData.downvoteUsers!.add(userController.loggedInUser);
      }
    }
    update();
    return reviewRef
        .doc(reviewData.id)
        .set(reviewData.toMap(), SetOptions(merge: true));
  }

  Future launchSourceURL(String url) {
    return launchWebUrl(url).onError((error, stackTrace) => print(error));
  }
}

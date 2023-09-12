import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/health_condition.dart';
import 'package:medzo/model/user_model.dart';

class AllUserController extends GetxController {
  RxList<UserModel> allUsers = <UserModel>[].obs;

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  String userId = FirebaseAuth.instance.currentUser!.uid;
  UserModel? currentUser;

  List<UserModel> bestMatchesUserList = [];

  @override
  void onInit() {
    log('AllUserController onInit');
    super.onInit();
    fetchAllUser();
    fetchCurrentUser();
  }

  fetchCurrentUser() async {
    try {
      currentUser = await fetchUser(userId);
    } catch (e) {
      print("An Error Occured : $e");
    }
  }

  fetchAllUser() {
    try {
      UserRepository.instance.streamAllUser().listen((updatedUserData) async {
        print(
            'updatedUserData fetchAllUser hasData ${updatedUserData.isNotEmpty}');
        if (updatedUserData.isNotEmpty) {
          allUsers.value = updatedUserData;
          bestMatchesUserList = await findBestMatches(
              allUsers.firstWhere((element) =>
                  element.id == FirebaseAuth.instance.currentUser!.uid),
              allUsers);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  UserModel findSingleUserFromAllUser(String userId) {
    UserModel user = allUsers.firstWhere((element) => element.id == userId);
    return user;
  }

  Stream<List<UserModel>> fetchMatchesUser(String profession) {
    var data = userRef
        // .where("profession", isEqualTo: profession)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return UserModel.fromMap(e.data() as Map<String, dynamic>);
      }).toList();
    });
    return data;
  }

  // fetch current logged in user detail using currentUser.uid from users collection from firestore database
  Future<UserModel> fetchUser(String? userId) async {
    UserModel updatedUserData =
        await UserRepository.instance.fetchUser(userId!);
    return updatedUserData;
  }

  double calculateSimilarity(UserModel user1, UserModel user2) {
    double ageSimilarity;
    if (user1.ageGroup != false && user2.ageGroup != false) {
      if (user1.ageGroup?.age != null && user2.ageGroup?.age != null) {
        if ((user1.ageGroup.age - 2) <= user2.ageGroup.age &&
            user2.ageGroup.age <= (user1.ageGroup.age + 2)) {
          ageSimilarity = 1;
        } else {
          ageSimilarity = 0;
        }
      } else {
        ageSimilarity = 0;
      }
    } else {
      ageSimilarity = 0;
    }

    double allergiesSimilarity;

    if (user1.allergies != false && user2.allergies != false) {
      if (user1.allergies?.currentAllergies != null &&
          user2.allergies?.currentAllergies != null) {
        allergiesSimilarity = calculateStringSimilarity(
            user1.allergies!.currentAllergies,
            user2.allergies!.currentAllergies);
      } else {
        allergiesSimilarity = 0;
      }
    } else {
      allergiesSimilarity = 0;
    }

    double medicationSimilarity;

    if (user1.currentMedication != false && user2.currentMedication != false) {
      if (user1.currentMedication != null && user2.currentMedication != null) {
        medicationSimilarity = calculateMedicationSimilarity(
            user1.currentMedication, user2.currentMedication);
      } else {
        medicationSimilarity = 0;
      }
    } else {
      medicationSimilarity = 0;
    }

    double healthConditionSimilarity;

    if (user1.healthCondition != false && user2.healthCondition != false) {
      if (user1.healthCondition != null && user2.healthCondition != null) {
        healthConditionSimilarity = calculateHealthConditionSimilarity(
            user1.healthCondition, user2.healthCondition);
      } else {
        healthConditionSimilarity = 0;
      }
    } else {
      healthConditionSimilarity = 0;
    }

    double overallSimilarity = (ageSimilarity +
            allergiesSimilarity +
            medicationSimilarity +
            healthConditionSimilarity) /
        4;
    return overallSimilarity;
  }

  double calculateStringSimilarity(String s1, String s2) {
    int intersection = 0;
    for (int i = 0; i < s1.length; i++) {
      if (s2.contains(s1[i])) {
        intersection++;
      }
    }

    int maxLen = s1.length > s2.length ? s1.length : s2.length;
    double similarity = intersection / maxLen;

    return similarity;
  }

  double calculateMedicationSimilarity(
      CurrentMedication medication1, CurrentMedication medication2) {
    double similarityScore = 0.0;
    if (!(medication1.takingMedicine! || medication2.takingMedicine!)) {
      similarityScore *= 0.2;
    } else {
      double medicineNameSimilarity = calculateStringSimilarity(
          medication1.currentTakingMedicine!,
          medication2.currentTakingMedicine!);

      num duration1 = parseDuration(medication1.durationTakingMedicine!);
      num duration2 = parseDuration(medication2.durationTakingMedicine!);
      num durationDifference = 1 - (duration1 - duration2).abs() / 100;

      similarityScore = (medicineNameSimilarity + durationDifference) / 2;
    }

    return similarityScore;
  }

  double calculateHealthConditionSimilarity(
      HealthCondition condition1, HealthCondition condition2) {
    double similarityScore = 0.0;

    if (!((condition1.doesHealthCondition ?? false) ||
        (condition2.doesHealthCondition ?? false))) {
      similarityScore *= 0.2;
    } else {
      double conditionNameSimilarity = calculateStringSimilarity(
          condition1.healthCondition!, condition2.healthCondition!);

      num duration1 = parseDuration(condition1.healthConditionDuration);
      num duration2 = parseDuration(condition2.healthConditionDuration);
      num durationDifference = 1 - (duration1 - duration2).abs() / 100;

      similarityScore = (conditionNameSimilarity + durationDifference) / 2;
    }

    return similarityScore;
  }

  List<UserModel> findBestMatches(
      UserModel currentUser, List<UserModel> userList) {
    List<UserModel> bestMatches = [];

    for (var user in userList) {
      double similarityScore = calculateSimilarity(currentUser, user);
      if (similarityScore > 0.7) {
        user.similarityScore = similarityScore;
        bestMatches.add(user);
      }
    }

    bestMatches
        .sort((a, b) => b.similarityScore!.compareTo(a.similarityScore!));

    bestMatchesUserList = bestMatches;
    print('bestMatches data ${bestMatches.map((e) => e.toString())}');
    return bestMatches;
  }

  num parseDuration(var duration) {
    if (duration is num) {
      return duration;
    } else if (duration is String) {
      try {
        return num.parse(duration);
      } catch (e) {
        // print('Failed to parse duration: $duration');
        return 0; // or some other default value
      }
    } else {
      // print('Unexpected type for duration: ${duration.runtimeType}');
      return 0; // or some other default value
    }
  }
}

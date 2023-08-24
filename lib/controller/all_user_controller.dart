import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';

class AllUserController extends GetxController {
  // current logged in user detail from users collection from firestore database
  RxList<UserModel> allUsers = <UserModel>[].obs;

  CollectionReference userRef = FirebaseFirestore.instance.collection("users");
  String userId = FirebaseAuth.instance.currentUser!.uid;
  UserModel? currentUser;

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
      UserRepository.instance.streamAllUser().listen((updatedUserData) {
        print(
            'updatedUserData fetchAllUser hasData ${updatedUserData.isNotEmpty}');
        if (updatedUserData.isNotEmpty) {
          allUsers.value = updatedUserData;
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
        .where("profession", isEqualTo: profession)
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
}




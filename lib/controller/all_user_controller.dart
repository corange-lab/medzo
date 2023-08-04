import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';

class AllUserController extends GetxController {
  // current logged in user detail from users collection from firestore database
  RxList<UserModel> allUsers = <UserModel>[].obs;

  @override
  void onInit() {
    log('AllUserController onInit');
    super.onInit();
    fetchAllUser();
  }

  void fetchAllUser() {
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

  // fetch current logged in user detail using currentUser.uid from users collection from firestore database
  Future<UserModel> fetchUser(String? userId) async {
    UserModel updatedUserData =
        await UserRepository.instance.fetchUser(userId!);
    return updatedUserData;
  }
}

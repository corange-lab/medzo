import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';

class UserController extends GetxController {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // AppStorage appStorage = AppStorage();

  String? get currentUserId => FirebaseAuth.instance.currentUser?.uid;

  User? get firebaseUser => FirebaseAuth.instance.currentUser;

  // current logged in user detail from users collection from firestore database
  Rx<UserModel> loggedInUser = UserModel().obs;

  @override
  void onInit() {
    log('UserController onInit');
    Get.lazyPut(() => AllUserController(), fenix: true);
    super.onInit();
    AllUserController allUserController = Get.find<AllUserController>();
    // allUserController.fetchAllUser();
    fetchUser();
  }

  // fetch current logged in user detail using currentUser.uid from users collection from firestore database
  Future<void> fetchUser(
      {void Function(UserModel userModel)? onSuccess}) async {
    try {
      UserRepository.instance
          .streamUser(currentUserId!)
          .listen((updatedUserData) {
        print('updatedUserData ${updatedUserData.name}');
        loggedInUser.value = updatedUserData;
        if (onSuccess != null) {
          onSuccess(updatedUserData);
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}

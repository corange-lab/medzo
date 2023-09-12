import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/login_screen.dart';

class HomeController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  RxInt pageIndex = 0.obs;

  TextEditingController searchController = TextEditingController();

  RxBool isChanged = false.obs;

  RxList<bool> isSaveMedicine = List.filled(5, false).obs;
  RxList<bool> isSaveExpert = List.filled(4, false).obs;

  var selectedPageIndex = 0.obs;
  var pageController = PageController().obs;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Rx<UserModel> loggedInUser = UserModel.newUser().obs;


  List categoryImage = [
    AppImages.painkiller,
    AppImages.antidepreset,
    AppImages.antibiotic,
    AppImages.cardiovascular,
    AppImages.supplements,
    AppImages.alergies,
    AppImages.devices,
    AppImages.hypnotics
  ];

  List categoryName = [
    ConstString.painkillar,
    ConstString.antidepresant,
    ConstString.antibiotic,
    ConstString.cardiovascular,
    ConstString.supplements,
    ConstString.allergies,
    ConstString.devices,
    ConstString.hypnotics
  ];

  String? userId;

  @override
  void onInit() {
    print(
        'Logged In user id ${FirebaseAuth.instance.currentUser?.uid ?? '-null-'}');
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser(
      {void Function(UserModel userModel)? onSuccess}) async {
    try {
      UserRepository.instance
          .streamUser(currentUserId)
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

  pageUpdateOnHomeScreen(int index, [String? userId]) {
    pageIndex.value = index;

    if (index == 3 && userId != null) {
      this.userId = userId;
    }

    update(['PageUpdate']);
    update();
  }

  static Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }

    await FirebaseAuth.instance.signOut();
    AppStorage appStorage = AppStorage();
    appStorage.appLogout();

    Get.offAll(() => LoginScreen());
  }
}

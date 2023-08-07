import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  List searchList = [
    "Cetirizine",
    "Cetuximab",
    "Cetraxal",
    "Cetamolol",
    "Cetilistat"
  ];
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

  @override
  void onInit() {
    print(
        'Logged In user id ${FirebaseAuth.instance.currentUser?.uid ?? '-null-'}');
    super.onInit();
  }

  pageUpdateOnHomeScreen(int index) {
    pageIndex.value = index;
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

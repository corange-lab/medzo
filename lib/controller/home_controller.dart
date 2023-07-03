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

  pageUpdateOnHomeScreen(int index) {
    pageIndex.value = index;
    update(['PageUpdate']);
    update();
  }

  Future<void> signOut() async {
    try {
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

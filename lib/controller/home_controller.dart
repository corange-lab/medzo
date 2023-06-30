import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/view/login_screen.dart';

class HomeController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

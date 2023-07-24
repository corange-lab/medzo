import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/api/create_user_api.dart';
import 'package:medzo/controller/auth_controller.dart';

class ForgotController extends GetxController {
  RxInt btnClick = 0.obs;

  static const String continueButtonId = 'Continue';

  bool emailValidate = false;

  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmpasswordTextController = TextEditingController();
  TextEditingController otpTextController = TextEditingController();

  String otpCode = '';

  var hidepass = true.obs;
  var hidepass2 = true.obs;

  RxInt startTimer() {
    start = 30.obs;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
          resendButton = false.obs;
        } else {
          start.value != 0 ? start-- : null;
        }
        update([ForgotController.continueButtonId]);
      },
    );
    return start;
  }

  void stopTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  Future<bool> sendOTP({required String email}) async {
    try {
      bool resendSuccess = await NewUser.instance.sendOTP(email: email);
      startTimer();
      return resendSuccess;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      bool resendSuccess =
          await NewUser.instance.verifyOTP(email: email, otp: otp);
      stopTimer();
      return resendSuccess;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<AuthResponse> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // String? verificationKey;
      // var value = await authApi.sendEmailVerification(email: email);
      // if (value != null && value is GeneralResponse) {
      //   verificationKey = value.details;
      // }
      return AuthResponse(
        success: true,
        // verificationKey: verificationKey
      );
    } catch (e) {
      return AuthResponse(
        errorMsg: "Human Doesn't exists",
        success: false,
      );
    }
  }

  void navigateToSignIn() {
    // Get.to(() => LoginScreen());
    Get.back();
    return;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';

class ForgotController extends GetxController {
  RxBool pageStatus = false.obs;
  RxInt btnClick = 0.obs;

  TextEditingController emailTextController = TextEditingController();

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
        errorMsg: "Hooman Doesn't exists",
        success: false,
      );
    }
  }
}

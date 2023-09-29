import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/api/create_user_api.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/controller_ids.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/view/question_screen.dart';

class OTPController extends GetxController {
  RxString otp = ''.obs;
  RxString userName = ''.obs;
  bool isLoading = false;
  RxBool disableLengthCheck = false.obs;

  bool googleSignInBool = false;
  RxBool isNewUser = false.obs;
  RxBool isOtpSent = false.obs;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController otpTextController = TextEditingController();

  static const String continueButtonId = 'Continue';

  String email;

  static String get googlesignin => "googlesignin";
  UserModel? userModel;
  User? user;
  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;
  List<TextEditingController?> otpController = [];
  bool socialButtonVisible = true;
  FocusNode phoneNumberTextField = FocusNode();
  AppStorage appStorage = AppStorage();

  OTPController({required this.email});

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  RxInt startTimer() {
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
        update([OTPController.continueButtonId]);
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

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? guser;
      guser = await googleSignIn.signIn();
      if (guser != null && guser.email.isNotEmpty) {
        final GoogleSignInAuthentication gauth = await guser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: gauth.accessToken, idToken: gauth.idToken);
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          user = userCredential.user!;

          showInSnackBar(ConstString.fetchGoogle, isSuccess: true);
          googleSignInBool = true;
        } else {
          showInSnackBar(ConstString.selectGoogleAccount);
        }
      } else {
        update(
            [AuthController.socialButtonId, AuthController.continueButtonId]);
      }
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        log('User canceled the sign-in process.');
      } else {
        log('An error occurred during sign-in: ${e.message}');
      }
    } catch (e) {
      log("-----------$e");
    }
  }

  Future verifyOtp({required String otp, required String email}) async {
    print('otp value ${otp}');
    if (otp.isEmpty) {
      showInSnackBar(
        ConstString.enterOtp,
        title: ConstString.enterOtpMessage,
      );
      return;
    }
    isLoading = true;
    update([ControllerIds.verifyButtonKey]);
    try {
      var verifyOTPResponse =
          await NewUser.instance.verifyOTP(email: email, otp: otp);
      if (!verifyOTPResponse) {
        return toast(
            message: "Please Enter Valid OTP",
            gravity: ToastGravity.CENTER,
            isSuccess: true,
            color: Colors.red);
      } else {
        Get.off(() => QuestionScreen());
      }

      isLoading = true;
      update([ControllerIds.verifyButtonKey]);
      stopTimer();

      // var gotNewUser = await createNewUserData(params: {
      //   "email": email,
      // });
      //
      // if (gotNewUser != null) {
      //   Get.offAll(() => HomeScreen());
      // }

      /*var gotUser = await NewUser.instance
          .fetchUser(id: result.user!.uid, ownProfile: true);

      if (gotUser != null) {
        await appStorage.setUserData(gotUser);
        Get.offAll(() =>  HomeScreen());
      }*/
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);

      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    } on FirebaseAuthException catch (e) {
      authException(e);
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    } catch (e) {
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    }
  }

  void authException(FirebaseAuthException e) {
    isLoading = false;
    update([ControllerIds.verifyButtonKey]);
    switch (e.code) {
      case ConstString.invalidVerificationCode:
        return showInSnackBar(ConstString.invalidVerificationMessage);
      case ConstString.networkRequestFailed:
        return showInSnackBar(ConstString.checkNetworkConnection);
      case ConstString.userDisabled:
        return showInSnackBar(ConstString.accountDisabled);
      case ConstString.sessionExpired:
        return showInSnackBar(ConstString.sessionExpiredMessage);
      case ConstString.quotaExceed:
        return showInSnackBar(ConstString.quotaExceedMessage);
      case ConstString.tooManyRequests:
        return showInSnackBar(ConstString.tooManyRequestsMessage);
      case ConstString.captchaCheckFailed:
        return showInSnackBar(ConstString.captchaFailedMessage);
      default:
        return showInSnackBar(e.message);
    }
  }

  Future<UserModel?> createNewUserData(
      {required Map<String, dynamic> params}) async {
    try {
      return await NewUser.instance.createUser(params: params);
    } catch (e) {
      log("$e", name: " error");
      return null;
    }
  }

  bool isLoggedIn() {
    UserModel? userData = AppStorage().getUserData();

    return userData != null;
  }

  Future<void> addFcmToken({required String fcmToken}) async {
    log(fcmToken, name: "fcm addd----2");
    try {
      var params = {
        "fcmToken": fcmToken,
      };
      await NewUser.instance.addFcmInUserData(params: params);
    } catch (e) {
      log('$e');
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
}

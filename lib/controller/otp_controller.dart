import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/api/create_user_api.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/services/notification/notification_service.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/controller_ids.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';

class OTPController extends GetxController {
  RxString verificationId = "".obs;
  RxString otp = ''.obs;
  RxString userName = ''.obs;
  RxString verificationid = "".obs;
  bool isLoading = false;
  RxBool disableLengthCheck = false.obs;

  bool googleSignInBool = false;
  RxBool isNewUser = false.obs;
  RxBool isOtpSent = false.obs;
  OtpFieldController otpFieldController = OtpFieldController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static String get googlesignin => "googlesignin";
  UserModel? userModel;
  User? user;
  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;
  TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool socialButtonVisible = true;
  FocusNode phoneNumberTextField = FocusNode();
  AppStorage appStorage = AppStorage();

  @override
  void onInit() {
    var dt = Get.arguments;
    verificationId = dt['verificationId'];
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
      },
    );
    return start;
  }

  Future<void> signInWithGoogle() async {
    try {
      bool hasInternet = await Utils.hasInternetConnection();
      if (!hasInternet) {
        showInSnackBar('noInternetConnection'.tr);
      } else {
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

  /*Future<void> verifyPhoneNumber({bool second = false}) async {
    isOtpSent = true.obs;
    update([AuthController.continueButtonId]);
    try {
      await _auth.verifyPhoneNumber(
        // forceResendingToken: int.fromEnvironment(name),
        phoneNumber: '+${getPhoneNumber()}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          isOtpSent = false.obs;
          update([AuthController.continueButtonId]);
          _auth.signInWithCredential(credential).then((value) {
            showInSnackBar(ConstString.successLogin, isSuccess: true);
            return;
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          isOtpSent = false.obs;
          update([AuthController.continueButtonId]);

          log("Verification error${exception.message}");
          authException(exception);
        },
        codeSent:
            (String currentVerificationId, int? forceResendingToken) async {
          verificationId.value = currentVerificationId;
          isOtpSent = false.obs;
          update([AuthController.continueButtonId]);
          log("$verificationId otp is sent ");

          showInSnackBar(ConstString.otpSent, isSuccess: true);

          start.value = 30;
          if (timer?.isActive != null) {
            if (timer!.isActive) {
            } else {
              startTimer();
            }
          } else {
            startTimer();
          }
          if (second == true) {
            otpController.clear();
          } else {
            return;
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isOtpSent = false.obs;
          update([AuthController.continueButtonId]);

          verificationid = verificationId.obs;
          // log("Verification ID ::: $verificationId");
        },
      );
    } catch (e) {
      log("------verifi number with otp sent-----$e");
    }
  }*/

  Future<void> verifyOtp(bool googleSignInBool, User? user) async {
    if (otp.value.isEmpty) {
      showInSnackBar(
        ConstString.enterOtp,
        title: ConstString.enterOtpMessage,
      );
      return;
    }
    isLoading = true;
    update([ControllerIds.verifyButtonKey]);
    try {
      final UserCredential result;
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId.value, smsCode: otp.value);

      if (googleSignInBool || user != null) {
        if (user!.phoneNumber == null) {
          result = await user.linkWithCredential(phoneAuthCredential);

          log("------------link part---------$result");
          if (result.user!.phoneNumber != null) {
            showInSnackBar(ConstString.linkSuccess, isSuccess: true);
          }
          await createNewUserData(params: {
            "email": result.user!.email,
          });
        } else {
          result = await _auth.signInWithCredential(phoneAuthCredential);
          log(ConstString.successLogin);
        }
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      } else {
        result = await _auth.signInWithCredential(phoneAuthCredential);
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      }
      isLoading = true;
      update([ControllerIds.verifyButtonKey]);
      if (result.additionalUserInfo?.isNewUser ?? false) {
        await createNewUserData(params: {
          "email": result.user!.email,
        });
        var gotUser = await NewUser.instance
            .fetchUser(id: result.user!.uid, ownProfile: true);

        if (gotUser != null) {
          await appStorage.setUserData(gotUser);
          await NotificationService.instance.getTokenAndUpdateCurrentUser();
          Get.offAll(() => const HomeScreen());
        }
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      } else {
        var gotUser = await NewUser.instance
            .fetchUser(id: result.user!.uid, ownProfile: true);
        if (gotUser == null) {
          return;
        }
        await appStorage.setUserData(gotUser);
        await NotificationService.instance.getTokenAndUpdateCurrentUser();
        Get.offAll(() => const HomeScreen());
        isLoading = false;
        update([ControllerIds.verifyButtonKey]);
      }
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
    if (e.code == ConstString.invalidVerificationCode) {
      showInSnackBar(ConstString.invalidVerificationMessage);
      isLoading = false;
      update([ControllerIds.verifyButtonKey]);
    } else if (e.code == ConstString.networkRequestFailed) {
      showInSnackBar(ConstString.checkNetworkConnection);
    } else if (e.code == ConstString.userDisabled) {
      showInSnackBar(ConstString.accountDisabled);
    } else if (e.code == ConstString.sessionExpired) {
      showInSnackBar(ConstString.sessionExpiredMessage);
    } else if (e.code == ConstString.quotaExceed) {
      showInSnackBar(ConstString.quotaExceedMessage);
    } else if (e.code == ConstString.tooManyRequest) {
      showInSnackBar(ConstString.tooManyRequestMessage);
    } else if (e.code == ConstString.captchaCheckFailed) {
      showInSnackBar(ConstString.captchaFailedMessage);
    } else {
      showInSnackBar(e.message);
    }
  }

  Future<void> createNewUserData({required Map<String, dynamic> params}) async {
    try {
      final UserModel? response =
          await NewUser.instance.createUser(params: params);
      await addFcmToken(
        fcmToken: NotificationService.instance.deviceToken ?? "",
      );
      log("$response", name: " param");
    } catch (e) {
      log("$e", name: " error");
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

}

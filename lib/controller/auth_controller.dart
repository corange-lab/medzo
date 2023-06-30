import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/api/create_user_api.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/controller_ids.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:medzo/view/login_screen.dart';
import 'package:medzo/view/otp_screen.dart';
import 'package:medzo/view/signup_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  bool social = false;
  RxString verificationId = "".obs;
  RxString otp = ''.obs;
  RxString userName = ''.obs;
  bool isLoading = false;
  var hidepass = true.obs;
  var hidepass2 = true.obs;

  bool socialSignInBool = false;
  RxBool isOtpSent = false.obs;
  OtpFieldController otpFieldController = OtpFieldController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String countryName = '';
  UserModel? userModel;
  User? user;
  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;
  // TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController supemailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController suppasswordTextController = TextEditingController();

  bool socialButtonVisible = true;
  // FocusNode phoneNumberTextField = FocusNode();
  AppStorage appStorage = AppStorage();

  static const socialButtonId = 'socialButtonId';
  static const continueButtonId = 'continueButtonId';

  late Rx<User?> firebaseUser;

  UserCredential? _authResult;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());

    // ever(firebaseUser, _setInitialScreen);
  }

  /*_setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }*/

  void navigateToSignUp() {
    Get.to(() =>  SignUpScreen());
    return;
  }

  void navigateToHomeScreen() {
    Get.offAll(() => const HomeScreen());
    return;
  }
  void navigateVerificationFlow() {
    Get.to(() => OTPScreen());
    return;
  }

  @override
  void dispose() {
    // phoneNumberController.clear();
    // phoneNumberController.dispose();
    // phoneNumberTextField.dispose();
    // log("phone dispose---${phoneNumberController.text}");
    social = false;
    update([socialButtonId, continueButtonId]);
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      String email = emailTextController.text.trim();
      String password = passwordTextController.text;

      if (email.isEmpty || password.isEmpty) {
        showInSnackBar('Email and password both is required!');
        return;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Signed in with uid: ${userCredential.user!.uid}');
      userCredential.user!.emailVerified;
      // TODO: Vijay check and handle verification screen for not verified user userCredential.user!.emailVerified
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          navigateToHomeScreen();
        }
        else {
          navigateVerificationFlow();
        }
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);

      update([continueButtonId]);

      isLoading = false;
      update([ControllerIds.verifyButtonKey]);

      authException(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp() async {
    try {
      String email = supemailTextController.text.trim();
      String password = suppasswordTextController.text;

      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Account created for user: " + (_authResult?.user?.email ?? ''));
      _authResult?.user?.sendEmailVerification();
      if (_authResult?.user!.emailVerified?? false) {
        navigateToHomeScreen();
        showInSnackBar('SignUp successfully with $email mail address');
      }
      else {
        navigateVerificationFlow();
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);

      update([continueButtonId]);

      isLoading = false;
      update([ControllerIds.verifyButtonKey]);

      authException(e);
    } catch (e) {
      print(e);
    }
  }

  Future<void> navigateToNextScreen(UserCredential credentials) async {
    UserModel? gotUser = await NewUser.instance
        .fetchUser(id: credentials.user!.uid, ownProfile: true);

    isLoading = false;
    update([ControllerIds.verifyButtonKey]);
    if (gotUser != null) {
      await appStorage.setUserData(gotUser);
      Get.offAll(() => const HomeScreen());
    }
  }

  Future signInWithgoogle() async {
    if (isOtpSent.value) {
      return;
    }
    isLoading = true;
    social = true;
    update([socialButtonId, continueButtonId]);
    try {
      await signInWithGoogle();
      if (socialSignInBool && FirebaseAuth.instance.currentUser != null) {
        await checkAfterSocialSignin(socialLoginType: "Google");
      }
    } on PlatformException catch (_) {
      log('Platform Exception ------------------------------');
      social = false;
      update([socialButtonId, continueButtonId]);
    } catch (e) {
      social = false;
      update([socialButtonId, continueButtonId]);
      log("-----------$e");
    }
    isLoading = false;
    update([socialButtonId, continueButtonId]);
  }

  Future<void> signInWithApple() async {
    if (isOtpSent.value) {
      return;
    }
    isLoading = true;
    social = true;
    update([socialButtonId, continueButtonId]);
    try {
      await signinWithApple();
      if (socialSignInBool && FirebaseAuth.instance.currentUser != null) {
        await checkAfterSocialSignin(socialLoginType: 'Apple ID');
      }
    } on PlatformException catch (_) {
      log('Platform Exception ------------------------------');
      social = false;
      update([socialButtonId, continueButtonId]);
    } catch (e) {
      social = false;
      update([socialButtonId, continueButtonId]);
      log("-----------$e");
    }
    isLoading = false;
    update([socialButtonId]);
  }

  Future<void> checkAfterSocialSignin({required String socialLoginType}) async {
    User user = FirebaseAuth.instance.currentUser!;
    final String? userphone = user.phoneNumber;
    final String? useremail = user.email;
    final String useruid = user.uid;

    if (useremail != null && useremail.isNotEmpty) {
      if (userphone != null && userphone.isNotEmpty) {
        UserModel? currentUser =
            await NewUser.instance.fetchUser(id: useruid, ownProfile: true);
        if (currentUser != null) {
          await appStorage.setUserData(currentUser);
          Get.offAll(() => const HomeScreen());
        } else {
          showInSnackBar(
              "Sorry, we couldn't retrieve the user details. Please try again later.");
        }
      } else {
        showInSnackBar(ConstString.linkSuccess, isSuccess: true);

        socialButtonVisible = false;
        update([socialButtonId, continueButtonId]);
      }
    }
    log(userphone.toString());
    isLoading = false;
    social = false;
    update([socialButtonId, continueButtonId]);
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

  Future<void> signinWithApple() async {
    try {
      if (await SignInWithApple.isAvailable()) {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.corange.medzo',
            redirectUri: Uri.parse(
              'https://medzo-2687b.firebaseapp.com/__/auth/handler',
            ),
          ),
        );

        final oauthCredential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        UserCredential? userCredential =
            await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        if (userCredential.user != null) {
          user = userCredential.user!;
          showInSnackBar(ConstString.fetchApple, isSuccess: true);
          socialSignInBool = true;
        }
      } else {
        social = false;
        update([socialButtonId, continueButtonId]);
      }
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        log('User canceled the sign-in process.');
        social = false;
        update([socialButtonId, continueButtonId]);
      } else {
        log('An error occurred during sign-in: ${e.message}');
        social = false;
        update([socialButtonId, continueButtonId]);
      }
    } catch (e) {
      log("-----------$e");
      social = false;
      update([socialButtonId, continueButtonId]);
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
          socialSignInBool = true;
          navigateToHomeScreen();
        } else {
          showInSnackBar(ConstString.selectGoogleAccount);
        }
      } else {
        social = false;
        update([socialButtonId, continueButtonId]);
      }
    } on PlatformException catch (e) {
      if (e.code == 'sign_in_canceled') {
        log('User canceled the sign-in process.');
      } else {
        log('An error occurred during sign-in: ${e.message}');
      }
      log("-----------$e");
    } catch (e) {
      log("-----------$e");
      social = false;
      update([socialButtonId, continueButtonId]);
    }
  }

  /*Future<void> verifyPhoneNumber({bool second = false}) async {
    bool isValid = validateData();
    if (isValid) {
      isOtpSent = true.obs;
      update([continueButtonId]);
      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: '+${getPhoneNumber()}',
          verificationCompleted: (PhoneAuthCredential credential) async {
            isOtpSent = false.obs;
            update([continueButtonId]);
            _auth.signInWithCredential(credential).then((value) {
              showInSnackBar(ConstString.successLogin, isSuccess: true);
              return;
            });
          },
          verificationFailed: (FirebaseAuthException exception) {
            isOtpSent = false.obs;
            update([continueButtonId]);

            log("Verification error${exception.message}");
            isLoading = false;
            update([ControllerIds.verifyButtonKey]);
            authException(exception);
          },
          codeSent:
              (String currentVerificationId, int? forceResendingToken) async {
            verificationId.value = currentVerificationId;
            isOtpSent = false.obs;
            update([continueButtonId]);
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
              Get.to(() => OTPScreen(email: email, verificationId: verificationId));
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            isOtpSent = false.obs;
            update([continueButtonId]);

            this.verificationId.value = verificationId;
          },
        );
      } catch (e) {
        log("------verifi number with otp sent-----$e");
      }
    }
  }*/

  Future<void> createNewUserData({required Map<String, dynamic> params}) async {
    try {
      final UserModel? response =
          await NewUser.instance.createUser(params: params);
      log("$response", name: " param");
    } catch (e) {
      log("$e", name: " error");
    }
  }

  bool isLoggedIn() {
    UserModel? userData = AppStorage().getUserData();

    return userData != null;
  }

  Future<void> signOut() async {
    otpController.text = "";
    otpController.clear();
    try {
      await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
    await FirebaseAuth.instance.signOut();
    AppStorage appStorage = AppStorage();
    appStorage.appLogout();
    isLoading = false;

    Get.delete<AuthController>();
    Get.put(AuthController(), permanent: true);
    Get.offAll(() =>  LoginScreen());
  }

  // bool validateData() {
  //   if (phoneNumberController.text.trim().isEmpty) {
  //     showInSnackBar("Please enter phone number.", isSuccess: false);
  //     return false;
  //   }
  //   return true;
  // }

  Future<void> addFcmToken({required String fcmToken}) async {
    log(fcmToken, name: "fcm addd----");
    try {
      var params = {
        "fcmToken": fcmToken,
      };
      await NewUser.instance.addFcmInUserData(params: params);
    } catch (e) {
      log('$e');
    }
  }

  void authException(FirebaseAuthException e) {
    isLoading = false;
    update([ControllerIds.verifyButtonKey]);
    if (e.code == ConstString.invalidEmail) {
      showInSnackBar(ConstString.invalidEmailMessage);
    } else if (e.code == ConstString.wrongPassword) {
      showInSnackBar(ConstString.wrongPasswordMessage);
    } else if (e.code == ConstString.userNotFound) {
      showInSnackBar(ConstString.userNotFoundMessage);
    } else if (e.code == ConstString.tooManyRequests) {
      showInSnackBar(ConstString.tooManyRequestsMessage);
    } else if (e.code == ConstString.operationNotAllowed) {
      showInSnackBar(ConstString.operationNotAllowedMessage);
    } else if (e.code == ConstString.emailAlreadyInUse) {
      showInSnackBar(ConstString.emailAlreadyInUseMessage);
    } else if (e.code == ConstString.invalidVerificationCode) {
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
}

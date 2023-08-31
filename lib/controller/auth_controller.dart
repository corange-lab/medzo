import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/api/create_user_api.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/service/notification/notification_service.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/controller_ids.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:medzo/view/login_screen.dart';
import 'package:medzo/view/otp_screen.dart';
import 'package:medzo/view/question_screen.dart';
import 'package:medzo/view/signup_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  bool social = false;
  RxString otp = ''.obs;
  RxString userName = ''.obs;
  bool isLoading = false;
  var hidepass = true.obs;
  var hidepass2 = true.obs;

  bool socialSignInBool = false;
  RxBool isOtpSent = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String countryName = '';
  UserModel? userModel;
  User? user;
  Timer? timer;
  RxInt start = 30.obs;
  RxBool resendButton = true.obs;
  TextEditingController otpController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController supemailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController suppasswordTextController = TextEditingController();

  bool socialButtonVisible = true;
  AppStorage appStorage = AppStorage();

  static const socialButtonId = 'socialButtonId';
  static const continueButtonId = 'continueButtonId';

  late Rx<User?> firebaseUser;

  UserCredential? _authResult;

  AuthApi authApi = AuthApi.instance;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  void navigateToSignUp() {
    Get.to(() => SignUpScreen());
    return;
  }

  Future<void> navigateToHomeScreen() async {
    UserModel? userModel = await AuthApi.instance.getLoggedInUserData();
    int currentQuestionnairesPosition = hasQuestionnairesCompleted(userModel);
    if (currentQuestionnairesPosition == -1) {
      return Get.offAll(() => HomeScreen());
    } else {
      return Get.off(() => QuestionScreen(
          currentQuestionnairesPosition: currentQuestionnairesPosition));
    }
  }

  int hasQuestionnairesCompleted(UserModel? userModel) {
    int position = -1;
    if (userModel?.healthCondition == null) {
      position = 0;
    } else if (userModel?.currentMedication == null) {
      position = 1;
    } else if (userModel?.allergies == null) {
      position = 2;
    } else if (userModel?.ageGroup == null) {
      position = 3;
    } else {
      return position;
    }
    return position;
  }

  void navigateVerificationFlow(String email, AuthResponse? newUser) {
    // TODO: uncomment below code
    Get.to(() => OTPScreen(
          email: email,
        ));
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
        Get.back();
        // showInSnackBar('Email and password both is required!');
        toast(message: "Email and password both is required!");
        return;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Signed in with uid: ${userCredential.user!.uid}');
      // AuthResponse newUser = await signUpWithEmailPassword(email, password,
      //     credentials: userCredential);
      AuthResponse newUser = await signInWithEmailPassword(email, password);
      // TODO: Vijay check and handle verification screen for not verified user userCredential.user!.emailVerified
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          navigateToHomeScreen();
        } else {
          navigateVerificationFlow(email, newUser);
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      print('Failed with error code: ${e.code}');
      print(e.message);

      update([continueButtonId]);

      isLoading = false;
      update([ControllerIds.verifyButtonKey]);

      authException(e);
    } catch (e) {
      Get.back();
      print(e);
    }
  }

  Future<void> signUp() async {
    try {
      String email = supemailTextController.text.trim();
      String password = suppasswordTextController.text;
      AuthResponse? newUser;
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_authResult != null) {
        newUser = await signUpWithEmailPassword(email, password,
            credentials: _authResult!);
      }
      print("Account created for user: ${_authResult?.user?.email ?? ''}");

      if (_authResult?.user!.emailVerified ?? false) {
        navigateToHomeScreen();
        // showInSnackBar('SignUp successfully with $email mail address');
        toast(message: "SignUp successfully with $email mail address");
      } else {
        navigateVerificationFlow(email, newUser);
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      print('Failed with error code: ${e.code}');
      print(e.message);

      update([continueButtonId]);

      isLoading = false;
      update([ControllerIds.verifyButtonKey]);

      authException(e);
    } catch (e) {
      Get.back();
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
      Get.offAll(() => HomeScreen());
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
      Get.back();
      log('Platform Exception ------------------------------');
      social = false;
      update([socialButtonId, continueButtonId]);
    } catch (e) {
      Get.back();
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
          Get.offAll(() => HomeScreen());
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
            clientId: 'android.apple.signin.com.corange.medzo',
            redirectUri: Uri.parse(
              'https://cosmic-knowing-sunfish.glitch.me/callbacks/sign_in_with_apple',
            ),
          ),
        );

        final oauthCredential = OAuthProvider('apple.com').credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        UserCredential? userCredential =
            await FirebaseAuth.instance.signInWithCredential(oauthCredential);
        if (userCredential.user?.email != null) {
          user = userCredential.user!;
          showInSnackBar(ConstString.fetchApple, isSuccess: true);
          socialSignInBool = true;

          if (userCredential.user != null) {
            if (userCredential.user!.emailVerified) {
              List<String> name = getFirstLastName(userCredential);
              await userCredential.user!.updateDisplayName(
                  userCredential.user?.displayName ?? name.join(' '));
              userModel = await _createUserInUserCollection(
                userCredential,
              );
              navigateToHomeScreen();
            } else {
              await signUpWithEmailPassword(user!.email!, '',
                  credentials: userCredential);
              // navigateVerificationFlow(userCredential.user.email, newUser);

              // TODO: handle different flow for social login
            }
          }
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
          if (userCredential.user != null) {
            if (userCredential.user!.emailVerified) {
              List<String> name = getFirstLastName(userCredential);
              await userCredential.user!.updateDisplayName(
                  userCredential.user?.displayName ?? name.join(' '));
              userModel = await _createUserInUserCollection(
                userCredential,
              );
              navigateToHomeScreen();
            } else {
              AuthResponse newUser = await signUpWithEmailPassword(
                  user!.email!, '',
                  credentials: userCredential);
              navigateVerificationFlow(guser.email, newUser);

              // TODO: handle different flow for social login
            }
          }
        } else {
          // showInSnackBar(ConstString.selectGoogleAccount);
          toast(message: ConstString.selectGoogleAccount);
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
    Get.offAll(() => LoginScreen());
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

  String authException(FirebaseAuthException e) {
    isLoading = false;
    update([ControllerIds.verifyButtonKey]);
    String snackBarMessage;

    switch (e.code) {
      case ConstString.invalidEmail:
        snackBarMessage = ConstString.invalidEmailMessage;
        break;
      case ConstString.wrongPassword:
        snackBarMessage = ConstString.wrongPasswordMessage;
        break;
      case ConstString.userNotFound:
        snackBarMessage = ConstString.userNotFoundMessage;
        break;
      case ConstString.tooManyRequests:
        snackBarMessage = ConstString.tooManyRequestsMessage;
        break;
      case ConstString.operationNotAllowed:
        snackBarMessage = ConstString.operationNotAllowedMessage;
        break;
      case ConstString.emailAlreadyInUse:
        snackBarMessage = ConstString.emailAlreadyInUseMessage;
        break;
      case ConstString.invalidVerificationCode:
        snackBarMessage = ConstString.invalidVerificationMessage;
        break;
      case ConstString.networkRequestFailed:
        snackBarMessage = ConstString.checkNetworkConnection;
        break;
      case ConstString.userDisabled:
        snackBarMessage = ConstString.accountDisabled;
        break;
      case ConstString.sessionExpired:
        snackBarMessage = ConstString.sessionExpiredMessage;
        break;
      case ConstString.quotaExceed:
        snackBarMessage = ConstString.quotaExceedMessage;
        break;
      case ConstString.captchaCheckFailed:
        snackBarMessage = ConstString.captchaFailedMessage;
        break;
      default:
        snackBarMessage = e.message ?? ConstString.somethingWentWrong;
    }

    toast(message: snackBarMessage);
    return snackBarMessage;
  }

  Future<AuthResponse> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return AuthResponse(success: true);
    } catch (e) {
      return AuthResponse(
        errorMsg: "Human Doesn't exists",
        success: false,
      );
    }
  }

  // static String? currentUserId() => FirebaseAuth.instance.currentUser?.uid;
  String? currentUserId() {
    UserModel? userData = AppStorage().getUserData();
    return userData?.id;
  }

  Future<AuthResponse> signInWithEmailPassword(
      String email, String password) async {
    AuthResponse result;
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!(credentials.user?.emailVerified ?? true)) {
        result = AuthResponse(
            errorMsg: ConstString.verifyEmail,
            success: false,
            isVerified: false);
      } else {
        UserModel? user;
        // final user =
        //     await UserRepository.getInstance().getUserByEmail(email.trim());
        if (credentials.user != null) {
          user = await authApi.getUserDetails(
              userId: credentials.user!.uid, isLogin: true);

          ///
          if (user != null) {
            UserRepository.getInstance().updateUser(
              user.copyWith(
                fcmToken: NotificationService.instance.deviceToken,
              ),
            );
            authApi.updateUserDetails(userId: user.id!, params: {
              'fcmToken': NotificationService.instance.deviceToken,
            });
          }
        }
        result = AuthResponse(success: true, user: user, isVerified: true);
        log("$result", name: "fcm token login");
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = authException(e);
      result = AuthResponse(
        errorMsg: errorMsg,
        success: false,
      );
    } on Exception {
      result = AuthResponse(
        errorMsg: ConstString.somethingWentWrong,
        success: false,
      );
    }
    return result;
  }

  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password, {
    String? displayName,
    UserModel? user,
    required UserCredential credentials,
  }) async {
    AuthResponse result;
    UserModel? user;
    try {
      if (password.isNotEmpty) {
        List<String> name = getFirstLastName(credentials);
        user = await _createUserInUserCollection(
          credentials,
        );
        await credentials.user!
            .updateDisplayName(displayName ?? ('${name.first} ${name[1]}'));
        await authApi.sendEmailVerification(email: email);
      } else {
        if (!(displayName != null && displayName.isNotEmpty)) {
          List<String> name = getFirstLastName(credentials);
          displayName = name.join(' ');
        }
        user = await _createUserInUserModelCollection(user!,
            displayName: displayName);
      }

      result = AuthResponse(success: true, user: user);
      // await FirebaseAuth.instance.signOut();
      // await FirebaseAuth.instance.signInWithCustomToken(_user!.fcmToken!);
    } on FirebaseAuthException catch (e) {
      String errorMsg = authException(e);
      result = AuthResponse(errorMsg: errorMsg, success: false, user: user);
    } on Exception {
      result = AuthResponse(
        errorMsg: ConstString.somethingWentWrong,
        success: false,
      );
    }
    return result;
  }

  Future<UserModel> _createUserInUserCollection(
    UserCredential credentials, {
    String? displayName,
  }) async {
    late UserModel userModel;
    bool isUserExist =
        await UserRepository.getInstance().isUserExist(credentials.user!.uid);
    if (!isUserExist) {
      List<String> name = getFirstLastName(credentials);
      userModel = UserModel(
          id: credentials.user?.uid,
          email: credentials.user?.email,
          name: (displayName ?? ('${name.first} ${name[1]}')),
          profilePicture: credentials.user?.photoURL,
          fcmToken: NotificationService.instance.deviceToken);
      await UserRepository.getInstance().createNewUser(userModel);
    } else {
      userModel =
          await UserRepository.getInstance().fetchUser(credentials.user!.uid);
    }
    return userModel;
  }

  List<String> getFirstLastName(UserCredential credentials) {
    if (credentials.user?.displayName == null) {
      return getNameFromEmail(credentials.user?.email ?? '');
    } else {
      try {
        List<String> splitedString = credentials.user!.displayName!.split(' ');
        if (splitedString.isNotEmpty) {
          return [splitedString[0], splitedString[1]];
        } else {
          return getNameFromEmail(credentials.user?.email ?? '');
        }
      } catch (e) {
        return getNameFromEmail(credentials.user?.email ?? '');
      }
    }
  }

  List<String> getNameFromEmail(String email) {
    List<String> parts = email.split('@');

    if (parts.length != 2) {
      return ['-', ''];
    }

    String username = parts[0];

    List<String> nameParts = username.split('.');

    if (nameParts.isEmpty) {
      return [
        capitalizeFirstLetter(username),
        generateRandomNumbers(),
      ];
    }

    String firstName = capitalizeFirstLetter(nameParts[0]);
    String lastName =
        nameParts.length > 1 ? capitalizeFirstLetter(nameParts.last) : '';

    return [firstName, lastName];
  }

  String capitalizeFirstLetter(String word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1);
  }

  String generateRandomNumbers() {
    math.Random random = math.Random();
    return '${random.nextInt(9)}${random.nextInt(9)}${random.nextInt(9)}';
  }

  Future _createUserInUserModelCollection(
    UserModel user, {
    String? displayName,
  }) async {
    user = user.copyWith(
      name: displayName ?? user.name,
      profilePicture: user.profilePicture,
      fcmToken: NotificationService.instance.deviceToken,
    );
    await UserRepository.getInstance().updateUser(user);
    return user;
  }

  Future resetPassword(String newPassword) async {
    AuthResponse result;
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
      result = AuthResponse(
        success: true,
      );
    } on FirebaseAuthException catch (e) {
      String errorMsg = e.message!;
      if (errorMsg.contains('Unable to resolve host')) {
        errorMsg = ConstString.noInternet;
      }
      result = AuthResponse(
        errorMsg: errorMsg,
        success: false,
      );
    } on Exception {
      result = AuthResponse(
        errorMsg: ConstString.somethingWentWrong,
        success: false,
      );
    }
    return result;
  }

  Future<bool> updateUsername(String displayName, Map<String, dynamic> latitude,
      String? gender, String location) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(displayName);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> params = {
      'name': displayName,
      "address": location,
      "gender": gender,
      'latitude': latitude['lat'],
      'longitude': latitude['lng'],
      'preferences': [
        {"size": "small", "likes": true},
        {"size": "medium", "likes": true},
        {"size": "large", "likes": true},
        {"size": "giant", "likes": true},
        {"size": "teacup", "likes": true},
        {"size": "toy", "likes": true}
      ]
    };
    dynamic hasUpdatedUser = await authApi
        .updateUserDetails(params: params, userId: userId)
        .onError((error, stackTrace) {
      return false;
    });
    return hasUpdatedUser != null;
  }

  Future<bool> updateUserProfilePic(String profilePicture) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(profilePicture);
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> params = {'profilePicture': profilePicture};

    dynamic hasUpdatedUser = await authApi
        .updateUserDetails(params: params, userId: userId)
        .onError((error, stackTrace) {
      return false;
    });
    return hasUpdatedUser != null;
  }

  Future<void> userLogout() async {
    //get user data
    AppStorage appStorage = AppStorage();
    UserModel? userData = appStorage.getUserData();
    //user data remove

    try {
      if (userData != null) {
        Map params = {UserModelField.fcmToken: null};
        await AuthApi.instance
            .updateUserDetails(params: params, userId: userData.id!);
        await authApi.updateUserDetails(userId: userData.id!, params: {
          'fcmToken': null,
        });
      }
    } catch (e) {
      log("User log out $e");
    }
    await FirebaseAuth.instance.signOut();
    await appStorage.appLogout();
  }

  Future<bool> checkCurrentPassword(String email, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!credentials.user!.emailVerified) {
        // showInSnackBar(ConstString.verifyEmail);
        toast(message: ConstString.verifyEmail);
        return false;
      } else {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      authException(e);
      return false;
    } on Exception {
      // showInSnackBar(ConstString.somethingWentWrong);
      toast(message: ConstString.somethingWentWrong);
      return false;
    }
  }
}

class AuthResponse {
  final bool? success;
  final bool? isVerified;
  final String? errorMsg;
  final String? token;
  final bool aborted;
  final UserModel? user;

  AuthResponse({
    this.success,
    this.isVerified,
    this.errorMsg,
    this.token,
    this.aborted = false,
    this.user,
  });
}

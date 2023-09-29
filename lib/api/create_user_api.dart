import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/api/api_defaults.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/network_api_urls.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/get_connect.dart';
import 'package:medzo/utils/string.dart';

class NewUser extends GetConnectImpl {
  AuthController authController = Get.find<AuthController>();

  NewUser._internal();

  static final instance = NewUser._internal();
  AppStorage appStorage = AppStorage();

  Future<UserModel?> createUser({required Map params}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    String url = APIRequest.createUser;

    final response = await post(
      url,
      jsonEncode(params),
      headers: APIDefaults.defaultHeaders(idToken),
    );
    printApiLog(url, response);
    // log("${response.statusCode}", name: "new user response");

    if (response.statusCode == 200) {
      Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

      if (!bodyMap.containsKey('data')) {
        APIDefaults.showApiStatusMessage(response);
        return Future.error("SOMETHING WENT WRONG");
      }
      if (bodyMap['data'] != null) {
        return UserModel.fromMap(bodyMap['data'] as Map<String, dynamic>);
      }
    } else if (response.statusCode == 403) {
      APIDefaults.showApiStatusMessage(response);
      await authController.signOut();
    } else {
      APIDefaults.showApiStatusMessage(
          response, "Unable to create a new user!");
      return null;
    }
    return null;
  }

  Future<UserModel?> fetchUser(
      {required String id, required bool ownProfile}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    String url = APIRequest.getUserUrl(id);
    try {
      final response =
          await get(url, headers: APIDefaults.defaultHeaders(idToken));
      printApiLog(url, response);
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('data')) {
          APIDefaults.showApiStatusMessage(response);
          log('error while calling if no data object $url');
          log('error while param if no data object $idToken');
          return Future.error("SOMETHING WENT WRONG");
        }
        if (bodyMap['data'] != null) {
          UserModel user =
              UserModel.fromMap(bodyMap['data'] as Map<String, dynamic>);
          if (ownProfile) {
            await appStorage.setUserData(user);
          }
          return user;
        }
      } else {
        log('error while calling else $url');
        log('error while param else $idToken');
        APIDefaults.showApiStatusMessage(response,
            "Sorry, we couldn't retrieve the user details. Please try again later.");
      }
    } catch (e) {
      log("fetch User error :: $e");
    }
    return null;
  }

  /*Future<UserModel?> updateUser({required Map<String, dynamic> params}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      return null;
    }
    String url = APIRequest.updateUserUrl();
    try {
      final response =
          await put(url, params, headers: APIDefaults.defaultHeaders(idToken));
      printApiLog(url, response);
      log('response.bodyString ${response.bodyString}');

      if (response.statusCode == 200) {
        log('User update api updated');
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('data')) {
          APIDefaults.showApiStatusMessage(response);
          return Future.error("SOMETHING WENT WRONG");
        }
        if (bodyMap['data'] != null) {
          UserModel user = UserModel.fromMap(bodyMap['data']);
          AppStorage appStorage = AppStorage();
          await appStorage.setUserData(user);

          return user;
        }
      } else if (response.statusCode == 403) {
        APIDefaults.showApiStatusMessage(response);
        await authController.signOut();
      } else if (response.hasError) {
        APIDefaults.showApiStatusMessage(response);
      } else {
        APIDefaults.showApiStatusMessage(response);
        return Future.error(ConstString.somethingWentWrong);
      }
    } catch (e) {
      log("update user api $e");
    }
    return null;
  }*/

  Future<String?> deleteUser(String id) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      return null;
    }
    String url = APIRequest.deleteUserUrl(id);
    try {
      final response =
          await delete(url, headers: APIDefaults.defaultHeaders(idToken));
      printApiLog(url, response);
      if (response.bodyString != null) {
        log('response.bodyString ${response.bodyString}');
        {
          if (response.statusCode == 200) {
            log('User update api updated');
            Map<String, dynamic> bodyMap =
                jsonDecode(response.bodyString ?? "{}");

            if (!bodyMap.containsKey('data')) {
              APIDefaults.showApiStatusMessage(response);
              return Future.error("SOMETHING WENT WRONG");
            }
            if (bodyMap['data'] != null) {
              return bodyMap['message'];
            }
          } else {
            APIDefaults.showApiStatusMessage(response);
            return Future.error("SOMETHING_WENT_WRONG");
          }
        }
      }
    } catch (e) {
      log("delete user api $e");
    }
    return null;
  }

  Future<bool> addFcmInUserData({required Map<String, dynamic> params}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    try {
      final Map<String, dynamic> body = params;
      String url = APIRequest.addFcmToken;
      final response =
          await post(url, body, headers: APIDefaults.defaultHeaders(idToken));
      printApiLog(url, response);
      if (response.bodyString != null) {
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('data')) {
          APIDefaults.showApiStatusMessage(response);
          return Future.error(ConstString.somethingWentWrong);
        }
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
        // if (bodyMap['data'] != null) {
        //   log("$params  ${bodyMap['message']}", name: "add fcm api---");
        //   return bodyMap['message'];
        // }
      } else {
        return false;
      }
    } catch (e) {
      log("add fcm api $e");
      return false;
    }
  }

  Future<bool> sendOTP({required String email}) async {
    try {
      String url = APIRequest.sendOTPUrl;
      Map<String, dynamic> params = {'email': email, 'type': 'REGISTER'};

      final response = await post(
        url,
        jsonEncode(params),
        // headers: APIDefaults.defaultHeaders(idToken),
      );
      printApiLog(url, response);
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('success')) {
          APIDefaults.showApiStatusMessage(response);
          log('error while calling if no data object $url');
          return Future.error("SOMETHING WENT WRONG");
        }
        return bodyMap['success'] != null && bodyMap['success'] == true;
      } else {
        log('error while calling else $url');
        APIDefaults.showApiStatusMessage(response,
            "Sorry, we couldn't retrieve the user details. Please try again later.");
        return false;
      }
    } catch (e) {
      log("fetch User error :: $e");
      return false;
    }
  }

  Future<bool> changePassword(
      {required String email, required String password}) async {
    try {
      String url = APIRequest.changePassword;
      Map<String, dynamic> params = {'email': email, 'password': password};

      final response = await put(url, jsonEncode(params));
      printApiLog(url, response);

      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('success')) {
          APIDefaults.showApiStatusMessage(response);
          log('error while calling if no data object $url');
          return Future.error("SOMETHING WENT WRONG");
        }
        return bodyMap['success'] != null && bodyMap['success'] == true;
      } else {
        log('error while calling else $url');
        APIDefaults.showApiStatusMessage(response,
            "Sorry, we couldn't retrieve the user details. Please try again later.");
        return false;
      }
    } catch (e) {
      log("fetch User error :: $e");
      return false;
    }
  }

  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      String url = APIRequest.verifyOTPUrl;
      Map<String, dynamic> params = {
        'email': email,
        'otp': otp,
        'type': 'REGISTER'
      };
      final response = await post(
        url,
        jsonEncode(params),
        // headers: APIDefaults.defaultHeaders(idToken),
      );
      printApiLog(url, response);
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.bodyString ?? "{}");

        if (!bodyMap.containsKey('success')) {
          APIDefaults.showApiStatusMessage(response);
          log('error while calling if no data object $url');
          return Future.error("SOMETHING WENT WRONG");
        }
        return bodyMap['success'] != null && bodyMap['success'] == true;
      } else {
        log('error while calling else $url');
        // APIDefaults.showApiStatusMessage(response,
        //     "Sorry, we couldn't retrieve the user details. Please try again later.");
        return false;
      }
    } catch (e) {
      log("fetch User error :: $e");
      return false;
    }
  }
}

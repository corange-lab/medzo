import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/api/api_defaults.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/network_api_urls.dart';
import 'package:medzo/services/notification/notification_service.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/get_connect.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';

class NewUser extends GetConnectImpl {
  AuthController authController = Get.find<AuthController>();

  NewUser._internal();
  static final instance = NewUser._internal();
  AppStorage appStorage = AppStorage();
  Future<UserModel?> createUser({required Map params}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      // showInSnackBar(ConstString.noConnection);
    } else {
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
    }
    return null;
  }

  Future<UserModel?> fetchUser(
      {required String id, required bool ownProfile}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    String url = APIRequest.getUserUrl(id);
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      // showInSnackBar(ConstString.noConnection);
      return null;
    } else {
      try {
        final response =
            await get(url, headers: APIDefaults.defaultHeaders(idToken));
        printApiLog(url, response);
        if (response.statusCode == 200) {
          Map<String, dynamic> bodyMap =
              jsonDecode(response.bodyString ?? "{}");

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
    }
    return null;
  }

  Future<UserModel?> updateUser({required Map<String, dynamic> params}) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      return null;
    }
    bool hasInternet = await Utils.hasInternetConnection();
    String url = APIRequest.updateUserUrl;
    try {
      if (!hasInternet) {
        // showInSnackBar(ConstString.noConnection);
      } else {
        final response = await put(url, params,
            headers: APIDefaults.defaultHeaders(idToken));
        printApiLog(url, response);
        log('response.bodyString ${response.bodyString}');

        if (response.statusCode == 200) {
          log('User update api updated');
          Map<String, dynamic> bodyMap =
              jsonDecode(response.bodyString ?? "{}");

          if (!bodyMap.containsKey('data')) {
            APIDefaults.showApiStatusMessage(response);
            return Future.error("SOMETHING WENT WRONG");
          }
          if (bodyMap['data'] != null) {
            // bodyMap['data'] != null ?  Data.fromJson(json['data']) : null;
            UserModel user = UserModel.fromMap(bodyMap['data']);
            // user = bodyMap['data'] != null
            //     ? UserModel.fromMap(bodyMap['data'])
            //     : null;
            // bodyMap['data']
            //     .map((e) => UserModel.fromMap(e as Map<String, dynamic>));
            AppStorage appStorage = AppStorage();
            await appStorage.setUserData(user);

            await addFcmInUserData(params: {
              "fcmToken": NotificationService.instance.deviceToken ?? "",
            });
            return user;
          }
          // return true;
        } else if (response.statusCode == 403) {
          APIDefaults.showApiStatusMessage(response);
          await authController.signOut();
        } else if (response.hasError) {
          APIDefaults.showApiStatusMessage(response);
        } else {
          APIDefaults.showApiStatusMessage(response);
          return Future.error(ConstString.somethingWentWrong);
        }
      }
    } catch (e) {
      log("update user api $e");
    }
    return null;
  }

  Future<String?> deleteUser(String id) async {
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    if (idToken == null) {
      return null;
    }
    bool hasInternet = await Utils.hasInternetConnection();
    String url = APIRequest.deleteUserUrl(id);
    try {
      if (!hasInternet) {
        // showInSnackBar(ConstString.noConnection);
      } else {
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
      }
    } catch (e) {
      log("delete user api $e");
    }
    return null;
  }

  Future<void> addFcmInUserData({required Map<String, dynamic> params}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    String? idToken = await FirebaseAuth.instance.currentUser?.getIdToken();

    try {
      if (!hasInternet) {
        // showInSnackBar(ConstString.noConnection);
      } else {
        final Map<String, dynamic> body = params;
        String url = APIRequest.addFcmToken;
        final response =
            await post(url, body, headers: APIDefaults.defaultHeaders(idToken));
        printApiLog(url, response);
        if (response.bodyString != null) {
          Map<String, dynamic> bodyMap =
              jsonDecode(response.bodyString ?? "{}");

          if (!bodyMap.containsKey('data')) {
            APIDefaults.showApiStatusMessage(response);
            return Future.error(ConstString.somethingWentWrong);
          }
          if (bodyMap['data'] != null) {
            log("$params  ${bodyMap['message']}", name: "add fcm api---");
            return bodyMap['message'];
          }
        }
      }
    } catch (e) {
      log("add fcm api $e");
    }
  }
}

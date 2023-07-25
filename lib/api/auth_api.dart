import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medzo/api/api_defaults.dart';
import 'package:medzo/model/general_response.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/user_response.dart';
import 'package:medzo/model/users_response.dart';
import 'package:medzo/network_api_urls.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:medzo/utils/get_connect.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';

class AuthApi extends GetConnectImpl {
  final AppStorage appStorage = AppStorage();

  AuthApi._internal();

  static final AuthApi instance = AuthApi._internal();

  Future<dynamic> sendEmailVerification({required String email}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      Map<String, String> params = {'email': email, 'type': 'REGISTER'};

      final response = await post(APIRequest.sendOTPUrl, jsonEncode(params),
          headers: APIDefaults.defaultHeaders(idToken));

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200) {
          return GeneralResponse.fromJson(jsonDecode(response.bodyString!));
        } else {
          return null;
        }
      }
    }
  }

  Future<AllUsersResponse?> fetchAllUsers(
      {String? keyword, int? pageNumber, int? pageSize}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      log(idToken.toString());
      Map<String, dynamic> query = {
        'pageNumber': pageNumber?.toString() ?? '1',
        'pageSize': pageSize?.toString() ?? '10',
      };
      if (keyword != null && keyword.isNotEmpty) {
        query['keyword'] = keyword;
      }
      final response = await get(
        APIRequest.getAllUsers(),
        headers: APIDefaults.defaultHeaders(idToken),
        query: query,
      );

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200) {
          final x = AllUsersResponse.fromJson(
              jsonDecode(response.bodyString!)['data']);
          log('body response ==>${x.users?.length}}');
          return x;
        } else {
          return null;
        }
      }
    }
    return null;
  }

  Future<dynamic> verifyOTP({required Map params}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      final response = await post(APIRequest.verifyOTPUrl, jsonEncode(params),
          headers: APIDefaults.defaultHeaders(idToken));

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200) {
          return GeneralResponse.fromJson(jsonDecode(response.bodyString!));
        } else {
          return null;
        }
      }
    }
  }

  static Future<String?> firebaseIdToken() async =>
      await FirebaseAuth.instance.currentUser?.getIdToken();

  Future<dynamic> updateUserDetails(
      {required String userId, required Map params}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      String url = APIRequest.updateUserUrl(userId);
      final response = await put(url, jsonEncode(params),
          headers: APIDefaults.defaultHeaders(idToken));

      if (response.status.hasError) {
        showInSnackBar(response.statusText!);
        return Future.error(response.bodyString ??
            response.statusText ??
            ConstString.somethingWentWrong);
      } else {
        if (response.statusCode == 200) {
          Map bodyMap = jsonDecode(response.bodyString!);
          if (!bodyMap.containsKey('data')) {
            String message =
                bodyMap['message'] ?? ConstString.somethingWentWrong;
            showInSnackBar(message);
            return Future.error(message);
          }
          if (bodyMap['data'] != null) {
            UserModel? user = UserModel.fromMap(bodyMap['data']);
            await appStorage.setUserData(user);
            await FirebaseAuth.instance.currentUser
                ?.updateDisplayName(user.name ?? "");
          }
          return UserResponse.fromJson(jsonDecode(response.bodyString!));
        } else {
          return Future.error(ConstString.somethingWentWrong);
        }
      }
    }
  }

  Future<UserModel?> getUserDetails(
      {required String userId, required bool isLogin}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      String url = APIRequest.getUserUrl(userId);
      final response =
          await get(url, headers: APIDefaults.defaultHeaders(idToken));

      Map bodyMap = {};
      String message = '';
      if (response.bodyString != null) {
        bodyMap = jsonDecode(response.bodyString!);
      }
      message = bodyMap['message'] ?? ConstString.somethingWentWrong;
      if (response.status.hasError) {
        showInSnackBar(message);
        return Future.error(message);
      } else {
        if (response.statusCode == 200) {
          if (!bodyMap.containsKey('data')) {
            showInSnackBar(message);
            return Future.error(message);
          }
          if (bodyMap['data'] != null) {
            UserModel? user = UserModel.fromMap(bodyMap['data']);
            if (isLogin) {
              await appStorage.setUserData(user);
            }

            return user;
          }
          showInSnackBar(ConstString.somethingWentWrong);
          return null;
        } else {
          return Future.error(ConstString.somethingWentWrong);
        }
      }
    }
    return null;
  }

  /*Future<PetsResponse?> fetchUserDogs(String userId) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      final response = await get(APIRequest.getUserPets(userId),
          headers: APIDefaults.defaultHeaders(idToken));

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200) {
          final x = PetsResponse.fromJson(jsonDecode(response.bodyString!));
          return x;
        } else {
          return Future.error(response.statusText!);
        }
      }
    }
  }*/

  /*Future<DogDetail?> createNewDog({required Map params}) async {
    bool hasInternet = await Utils.hasInternetConnection();
    if (!hasInternet) {
      showInSnackBar('noInternetConnection'.tr);
    } else {
      String? idToken = await firebaseIdToken();

      UserModel? userModel = appStorage.getUserData();
      if (userModel == null) {
        throw Exception('User not logged in.');
      }

      final response = await post(
          APIRequest.createNewDog(userModel.id!), jsonEncode(params),
          headers: APIDefaults.defaultHeaders(idToken));

      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        if (response.statusCode == 200) {
          Map<String, dynamic> mData = jsonDecode(response.bodyString!);
          return DogDetail.fromJson(mData['data']);
        } else {
          return Future.error(response.statusText!);
        }
      }
    }
  }*/
}

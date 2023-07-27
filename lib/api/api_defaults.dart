import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';

class APIDefaults {
  static Map<String, String> defaultHeaders(String? idToken) => {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $idToken',
      };

  static String showApiStatusMessage(Response<dynamic> response,
      [String? message]) {
    Map<String, dynamic> map = jsonDecode(response.bodyString ?? "{}");
    String messageString = message.toString();
    if (response.statusCode == 404) {
      messageString = map['message'] ??
          (message ?? "Unable to process. Please try again later.");
    } else if (response.statusCode == 400) {
      messageString = map['message'] ??
          (message ?? "Unauthorized. Please login to access this app.");
    } else if (response.statusCode == 401) {
      messageString = map['message'] ??
          (message ?? "Unauthorized. Please login to access this app.");
    } else if (response.statusCode == 403) {
      messageString = map['message'] ??
          (message ?? "Unauthorized. Please login to access this app.");
    } else if (response.statusCode == 500) {
      messageString = map['message'] ??
          (message ?? "Internal server error. Please try again later.");
    } else if (response.statusCode == 502) {
      messageString =
          map['message'] ?? (message ?? "Bad gateway. Please try again later.");
    } else {
      messageString = ConstString.somethingWentWrong;
    }
    if (response.statusCode == null) {
      messageString = "Internet connection unstable. Please retry in a moment.";
    }
    // showInSnackBar(messageString);
    toast(message: messageString);
    return messageString;
  }
}

class APIRequest {
  static String apiBaseUrl =
      'https://us-central1-medzo-18785.cloudfunctions.net/api/';

  static String createUser = "${apiBaseUrl}user";

  static String getUserUrl(String id) => "${apiBaseUrl}user/$id";

  static String deleteUserUrl(String id) => "${apiBaseUrl}user/$id";
  static String addFcmToken = "${apiBaseUrl}fcm_token";

  static String sendOTPUrl = '${apiBaseUrl}auth/otp/send';
  static String verifyOTPUrl = '${apiBaseUrl}auth/otp/verify';
  static String changePassword = '${apiBaseUrl}auth/password/change';
  static String dogDefaults = '${apiBaseUrl}pet/breed-size';

  static String updateUserUrl(String userId) => '${apiBaseUrl}users/$userId';

  static String getAllUsers() => '${apiBaseUrl}users';
}

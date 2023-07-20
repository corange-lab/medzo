class APIRequest {
  static String apiBaseUrl = 'https://australia-southeast1-barki-511d1.cloudfunctions.net/api/';

  static String createUser = "${apiBaseUrl}user";
  static String getUserUrl(String id) => "${apiBaseUrl}user/$id";
  static String deleteUserUrl(String id) => "${apiBaseUrl}user/$id";
  static String addFcmToken = "${apiBaseUrl}fcm_token";

  static String sendOTPUrl = '${apiBaseUrl}verify-email/send-otp';
  static String verifyOTPUrl = '${apiBaseUrl}verify-email/verify-otp';
  static String dogDefaults = '${apiBaseUrl}pet/breed-size';
  static String updateUserUrl(String userId) => '${apiBaseUrl}users/$userId';
  static String getAllUsers() => '${apiBaseUrl}users';

}

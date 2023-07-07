class APIRequest {
  static String apiBaseUrl = "http://54.206.89.99:5000/api/";

  static String createUser = "${apiBaseUrl}user";

  static String getUserUrl(String id) => "${apiBaseUrl}user/$id";

  static String deleteUserUrl(String id) => "${apiBaseUrl}user/$id";
  static String updateUserUrl = "${apiBaseUrl}user";
  static String addFcmToken = "${apiBaseUrl}fcm_token";
  static String otpSend = "${apiBaseUrl}/auth/otp/send";
}

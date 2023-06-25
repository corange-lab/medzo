import 'dart:core';

class ConstString {
  static const String apiTimeOut =
      "Something went wrong. Please try after some time.";
  static const int timeOutTimeInSeconds = 25;
  static const String somethingWentWrong = "Something went wrong";
  static const String noConnection = "No internet connection";
  static const String noDataFound =
      "Oops! Problem fetching details.";
  static const String noImages = "No images to display";
  static const String notConnected = "Not connected";
  static const String connected = "Connected";
  static const String noInternet = "Please Check Your Internet.";
  static const String internetLost = "Internet connection lost!";
  static const String internetReestablished = "Connection reestablished";

  // ---------------------------- Authentication Screens Strings ---------------------------- //

  static const String continueSocial = "Or continue with social login";
  static const String otp =
      "Please enter the one-time passcode from the SMS we sent you just now";
  static const String resendOtp = "Resend OTP";
  static const String privacyPolicy = "Privacy policy";
  static const String termsOfUse = "Terms of use";
  static const String deleteAccountH = "Delete account?";
  static const String deleteProfile = "Delete profile";
  static const String logoutH = "Logout?";
  static const String logoutQuestion =
      "Do you want to log out of your account?";
  static const String deleteAccountQuestion =
      "Do you want to delete your account?";

// ---------------------------- Button Names ----------------------------//

  static const String continueButton = "Continue";
  static const String startUsingApp = "Start using the app";
  static const String submitSuggestion = "Submit suggestion";
  static const String verify = "Verify";
  static const String getStarted = "Get started";
  static const String skipButton = "Skip";
  static const String cancel = "Cancel";
  static const String delete = "Delete image";
  static const String logout = "Logout";
  static const String report = "Report";
  static const String deleteAccount = "Delete account";
  static const String saveChanges = "Save changes";

// ---------------------------- AuthController Strings ----------------------------//

  static const String fetchGoogle =
      "Your Google account is fetched successfully";
  static const String fetchApple = "Your Apple account is fetched successfully";

  static const String connectedGoogle =
      "Your Google account is connected successfully";
  static const String connectedApple =
      "Your Apple account is connected successfully";

  static const String selectGoogleAccount = 'Please select Google account';
  static const String successLogin = 'You are logged-in successfully';
  static const String otpSent = 'OTP is sent to your emali';
  static const String enterOtp = "OTP is Required!";
  static const String enterOtpMessage = "Please enter OTP";
  static const String linkSuccess =
      "Your account is successfully linked to your email";

// ---------------------------- Authentication Error Codes ---------------------------- //

  static const String invalidVerificationCode = "invalid-verification-code";
  static const String networkRequestFailed = 'network-request-failed';
  static const String userDisabled = 'user-disabled';
  static const String alreadyInUse = 'credential-already-in-use';
  static const String sessionExpired = "session-expired";
  static const String quotaExceed = "quota-exceeded";
  static const String tooManyRequest = "too-many-requests";
  static const String captchaCheckFailed = 'captcha-check-failed';

// ---------------------------- Authentication Error Messages ---------------------------- //
  static const String tooManyRequestMessage =
      "To ensure the safety of your account, we've temporarily disabled access from this device due to suspicious activity. Please try again later.";
  static const String captchaFailedMessage =
      "Unable to verify Captcha. Please try again later.";
  static const String quotaExceedMessage =
      "The requested operation cannot be completed as it exceeds the project quota limit.";
  static const String sessionExpiredMessage =
      "The sms code has expired. Please re-send the verification code";
  static const String invalidVerificationMessage =
      "Oops! The OTP you entered is invalid. Please check and try again.";
  static const String checkNetworkConnection =
      'Check Your Network Connection and try again';
  static const String accountDisabled =
      "Your account has been disabled by an admin";

// ---------------------------- Emoticons Names ---------------------------- //

  static const String love = "love";
  static const String funny = "funny";
  static const String strong = "strong";
  static const String wise = "wise";
  static const String wow = "wow";

// ---------------------------- Photo types ---------------------------- //

  static const String profileType = "profile";
  static const String galleryType = "gallery";

// ---------------------------- Edit screens labels ---------------------------- //

  static const String editFirstName = "Your first name";
  static const String editLastName = "Your last name";
  static const String editBio = "Your bio";
  static const String titleBio = "Bio";
  static const String editusername = "Your username";
  static const String editDisplayName = "Your display name";
  static const String editPostCode = "Your postcode";
  static const String editGender = "Your gender";
  static const String editAge = "Your age";

// ---------------------------- Labels ---------------------------- //

  static const String gallery = 'Gallery';
  static const String camera = 'Camera';
  static const String galleryImage = "Gallery image";
  static const String bio = 'Bio';
  static const String interests = 'Interests';
  static const String popularComments = 'Popular comments';
  static const String recentComments = 'Recent comments';
  static const String profile = "Profile";
  static const String about = "About";
  static const String location = "Location";
  static const String contact = "Contact";
  static const String firstName = "First name";
  static const String lastName = "Last name";
  static const String displayUserName = "Display username";
  static const String gender = "Gender";
  static const String age = "Age";
  static const String country = "Country";
  static const String socialLogin = "Social logins";
  static const String unfollow = "Unfollow";
  static const String follow = "Follow";
  static const String hallOfBadges = "Hall of badges";
  static const String reactionbadge = "Reaction badges";
  static const String settings = "Settings";
  static const String reactonlistheadline = "Reactions";
  static const String accountDetails = "Account details";
  static const String appSetting = "App settings";
  static const String enablePushNotification = "Enable push notifications";
  static const String social = "Social";
  static const String inviteFriends = "Invite friends to use Topicks";
  static const String sendLinkToFriends =
      "Talking Topicks with friends in fun. Send this link to their mobile to get bonus points if they join!";
  static const String legal = "Legal";
  static const String notificationTitle = 'Notifications';
  static const String badgesandtrophititle = "Badges and Trophies";
  static const String pointstitle = "Points";
  static const String leaderboardtitle = "Leaderboard";
  static const String monthlyleaderboard = "Monthly Leaderboard";
  static const String weeklyleaderboard = "Weekly Leaderboard";

// ---------------------------- Social Media ---------------------------- //

  static const String apple = "Apple";
  static const String google = "Google";

// ---------------------------- bottomsheet Strings ---------------------------- //

  static const String options = "Options";
  static const String reportSubmitted = "Report submitted";
  static const String reportsubmittedstring =
      "Your report has been successfully submitted";
  static const String followUser = "Follow User";
  static const String unfollowUser = "Unfollow User";
  static const String reportUser = "Report";
  static const String editComment = "Edit comment";
  static const String editbio = "Edit bio";
  static const String editpostcode = "Edit postcode";
  static const String deleteComment = "Delete comment";

  //Privacy and terms

  static const String privacyUrl = "https://www.medzo.au/privacy";
  static const String termsUSe = "https://www.medzo.au/terms";

// ---------------------------- gender and age list ---------------------------- //

  static const List<String> genderList = [
    "Male",
    "Female",
    "Intersex",
    "Indeterminate",
  ];
}

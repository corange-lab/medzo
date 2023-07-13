import 'dart:core';

class ConstString {
  static const String apiTimeOut =
      "Something went wrong. Please try after some time.";
  static const int timeOutTimeInSeconds = 25;
  static const String somethingWentWrong = "Something went wrong";
  static const String noConnection = "No internet connection";
  static const String noDataFound = "Oops! Problem fetching details.";
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
  static const String next = "Next";
  static const String submit = "Submit";
  static const String addpost = "Add Post";
  static const String chat = "Chat";
  static const String follownow = "Follow Now";
  static const String editprofile = "Edit Profile";
  static const String message = "Message";
  static const String back = "Back";
  static const String sendotp = "Send OTP";
  static const String writereview = "Write a Review";
  static const String askquestion = "Ask a Questions";
  static const String savencontinue = "Save and Continue";
  static const String cancel = "Cancel";
  static const String delete = "Delete image";
  static const String logout = "Log Out";
  static const String report = "Report";
  static const String deleteAccount = "Delete account";
  static const String saveChanges = "Save changes";
  static const String save = "Save";
  static const String viewmoredetails = "View More Details";

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

  static const String invalidEmail = "invalid-email";
  static const String wrongPassword = "wrong-password";
  static const String userNotFound = "user-not-found";
  static const String tooManyRequests = "too-many-requests";
  static const String operationNotAllowed = "operation-not-allowed";
  static const String emailAlreadyInUse = "email-already-in-use";
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
  static const String invalidEmailMessage = "The email address is not valid.";
  static const String wrongPasswordMessage =
      "The password is invalid for the given email.";
  static const String userNotFoundMessage =
      "There is no user with the given email address.";
  static const String userDisabledMessage =
      "The user with the given email address has been disabled.";
  static const String tooManyRequestsMessage =
      "The user has exceeded the rate limit for auth attempts.";
  static const String operationNotAllowedMessage =
      "The auth operation is not allowed.";
  static const String emailAlreadyInUseMessage =
      "The email address is already in use.";
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
  static const String bookmark = "Bookmarks";
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
  static const String review = "Review";
  static const String addreview = "Add Review";
  static const String leavereview = "Leave a review here";
  static const String hallOfBadges = "Hall of badges";
  static const String rateproduct = "Rate the products";
  static const String reactionbadge = "Reaction badges";
  static const String settings = "Settings";
  static const String reactonlistheadline = "Reactions";
  static const String accountDetails = "Account details";
  static const String appSetting = "App settings";
  static const String enablePushNotification = "Enable push notifications";
  static const String social = "Social";
  static const String inviteFriends = "Invite friends to use Medzo";
  static const String legal = "Legal";
  static const String notificationTitle = 'Notifications';
  static const String badgesandtrophititle = "Badges and Trophies";
  static const String pointstitle = "Points";
  static const String leaderboardtitle = "Leaderboard";
  static const String monthlyleaderboard = "Monthly Leaderboard";
  static const String weeklyleaderboard = "Weekly Leaderboard";
  static const String welcomeback = "Welcome Back";
  static const String enterdetailstocontinue = "Enter your details to continue";
  static const String exploreandknowaboutmedicine = "Explore and know about your medicine...";
  static const String forgotpassword = "Forgot Password?";
  static const String login = "Log in";
  static const String sigup = "Sign Up";
  static const String category = "Categories";
  static const String description = "Description";
  static const String profession = "Profession";
  static const String name = "Name";
  static const String uploadimage = "Upload Images";
  static const String uploadpost = "Upload Post";
  static const String newpost = "New Post";
  static const String bookmarkpost = "Bookmark Posts";
  static const String allpost = "All Posts";
  static const String bestmarches = "Best Matches";
  static const String popularmedicine = "Popular Medicines";
  static const String popularquestions = "Popular Questions:";
  static const String mostrecent = "Most Recent";
  static const String viewreply = "View Replied";
  static const String ask = "Ask Real Time Q&A";
  static const String viewall = "View All";
  static const String viewall1 = "View All";
  static const String verifyotp = "Verify OTP";
  static const String orloginwith = "or log in with";
  static const String didnthaveanaccount = "Didn’t have an account? ";
  static const String didntreceivecode = "Didn’t receive code? ";
  static const String resendit = "Resend It";
  static const String alreadyhaveaccount = "Already have an account? ";
  static const String createaccount = "Create an Account";
  static const String createnewpassword = "Create new password";
  static const String passwordstrength = "Password Strength : ";
  static const String passrule1 = "Must not contain your name or email";
  static const String passrule2 = "At least 8 characters";
  static const String passrule3 = "Contain a symbol or a number";
  static const String clickicon = "Click icons for more informations";
  static const String newpassworddetail = "Your new password must be different from previously used password.";
  static const String verificationotp = "Verification OTP";
  static const String profilesentance = "Find your closest \nmatches for the best \nand most important \nreviews!";
  static const String otpdetails = "Please enter 4 Digit OTP sent on your email address us...23@gmail.com";

// ---------------------------- category ---------------------------- //

  static const String painkillar = "Painkillers";
  static const String antidepresant = "Anti-Depressants";
  static const String antibiotic = "Antibiotics";
  static const String cardiovascular = "Cardiovascular";
  static const String supplements = "Supplements";
  static const String allergies = "Allergies";
  static const String devices = "Devices";
  static const String hypnotics = "Hypnotics";
  static const String prescribed = "Prescribed";
  static const String allcategory = "All Categories";
  static const String search = "Search";
  static const String drowsiness = "Drowsiness";
  static const String pregnancy = "Pregnancy";
  static const String allergy = "Allergies";
  static const String olderage = "Older Age";
  static const String alcohol = "Alcohol";
  static const String maoi = "MAOIs";
  static const String therphy = "Theophylline";
  static const String drugs = "Drugs";


  static const String selectchoice = "Select Your Choice";

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

// ---------------------------- Questions ---------------------------- //

  static const String question1 = "Do you currently have any health conditions?";
  static const String question2 = "Specify the health conditions you have";
  static const String question3 = "How long have you been dealing with your current health condition?";
  static const String question4 = "Are you currently taking any medications?";
  static const String question5 = "Please list the medications you are currently taking";
  static const String question6 = "How long have you been taking these medications?";
  static const String question7 = "Do you have any allergies?";
  static const String question8 = "Please specify the allergies you have.";
  static const String question9 = "How severe are your allergies?";
  static const String question10 = "What is your age?";
  static const String question11 = "Which age group do you belong to?";

// ---------------------------- gender and age list ---------------------------- //

  static const List<String> genderList = [
    "Male",
    "Female",
    "Intersex",
    "Indeterminate",
  ];
}

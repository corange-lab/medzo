import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

Future progressDialogue(context, {required String title}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Container(
          height: 10.h,
          child: Column(
            children: [
              Expanded(
                child: GFLoader(
                  type: GFLoaderType.ios,
                  loaderstrokeWidth: 10,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextWidget(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.black,
                    fontSize: 13.sp,
                    fontFamily: AppFont.fontMedium,
                    letterSpacing: 0.5),
              )
            ],
          ),
        ),
      );
    },
  );
}

Future logoutDialogue(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.white,
        shape: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        alignment: Alignment.center,
        title: Column(
          children: [
            SvgPicture.asset(
              SvgIcon.logoutdialogue,
              height: 30,
            ),
            SizedBox(height: 25),
            Text(
              ConstString.logout,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.darkPrimaryColor,
                    fontFamily: AppFont.fontFamilysemi,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                "Are you sure you want to sign out?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: 13.5,
                    color: AppColors.grey.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.fontFamily,
                    letterSpacing: 0),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await HomeController.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(20, 55),
                        backgroundColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0),
                    child: Text(
                      "Yes",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColors.buttontext,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFont.fontMedium,
                              fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(20, 55),
                        backgroundColor: AppColors.splashdetail,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 0),
                    child: TextWidget(
                      "NO",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: AppColors.dark,
                              fontWeight: FontWeight.w500,
                              fontFamily: AppFont.fontMedium,
                              fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class successDialogue extends AlertDialog {
  final String titleText;
  final String subtitle;
  final String iconDialogue;
  final String btntext;
  final void Function()? onPressed;

  const successDialogue(
      {required this.titleText,
      required this.subtitle,
      required this.iconDialogue,
      required this.btntext,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      alignment: Alignment.center,
      title: Column(
        children: [
          SvgPicture.asset(
            iconDialogue,
            height: 50,
          ),
          SizedBox(height: 20),
          Text(
            titleText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.darkPrimaryColor,
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
          ),
          SizedBox(height: 5),
          TextWidget(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 13.5,
                  color: AppColors.grey.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFont.fontFamily,
                  letterSpacing: 0,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                fixedSize: Size(190, 55),
                backgroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 0),
            child: Text(
              btntext,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.buttontext,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFont.fontMedium,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class FailureDialog extends AlertDialog {
  final String titleText;
  final String subtitle;
  final String iconDialogue;
  final String btntext;
  final void Function()? onPressed;

  const FailureDialog(
      {required this.titleText,
      required this.subtitle,
      required this.iconDialogue,
      required this.btntext,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: AppColors.white,
      shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      alignment: Alignment.center,
      title: Column(
        children: [
          SvgPicture.asset(
            iconDialogue,
            color: Colors.red,
            height: 50,
          ),
          SizedBox(height: 20),
          Text(
            titleText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.darkPrimaryColor,
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
          ),
          SizedBox(height: 5),
          TextWidget(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 13.5,
                  color: AppColors.grey.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFont.fontFamily,
                  letterSpacing: 0,
                  height: 1.5,
                ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                fixedSize: Size(190, 55),
                backgroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 0),
            child: Text(
              btntext,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: AppColors.buttontext,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFont.fontMedium,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> showReportDialog(BuildContext context, String title,
    {bool isForUser = false}) async {
  Completer<String?> completer = Completer<String?>();

  showDialog(
    context: context,
    barrierDismissible: false, // Dialog will not be dismissed on tap outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Report ${title}',
            style: TextStyle(
              color: Color(0xffF29D38),
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: ReportOptions(
          onReportSelected: (String? selectedOption) {
            completer.complete(selectedOption);
            Get.back();
          },
          isForUser: isForUser,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      );
    },
  );

  return completer.future;
}

class ReportOptions extends StatefulWidget {
  final ValueChanged<String?> onReportSelected;

  final bool isForUser;

  const ReportOptions(
      {Key? key, required this.onReportSelected, required this.isForUser})
      : super(key: key);

  @override
  _ReportOptionsState createState() => _ReportOptionsState();
}

class _ReportOptionsState extends State<ReportOptions> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!widget.isForUser) ...[
              _buildReportOption('Inappropriate Content'),
              _buildReportOption('Spam'),
              _buildReportOption('Harassment'),
              _buildReportOption('False Information'),
              _buildReportOption('Violence or Threats'),
              _buildReportOption('Bullying'),
              _buildReportOption('Hate Speech'),
              _buildReportOption('Intellectual Property Violation'),
              _buildReportOption('Privacy Violation'),
              _buildReportOption('Child Endangerment'),
            ] else ...[
              _buildReportOption('Inappropriate Behavior',
                  subtitle:
                      'Harassment, bullying, offensive language, or fake accounts'),
              _buildReportOption('Spam or Misuse',
                  subtitle:
                      'Spamming, unwanted messages, posting irrelevant content, or misuse of platform features'),
              _buildReportOption('Violence or Threats',
                  subtitle:
                      'Threatening language, behavior, or promotion of violence/harm'),
              _buildReportOption('False Information',
                  subtitle:
                      'Spreading misinformation, fake news, or manipulation of content/data'),
              _buildReportOption('Privacy Violation',
                  subtitle:
                      'Sharing private/sensitive information without consent or unauthorized access to accounts'),
              _buildReportOption('Intellectual Property Violation',
                  subtitle: 'Copyright infringement or trademark violations'),
              _buildReportOption('Other',
                  subtitle:
                      'Any other issues not covered by specific categories'),
            ],
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.onReportSelected(null);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    elevation: 0,
                    onPrimary: Color(0xffF29D38),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedOption != null) {
                      widget.onReportSelected(selectedOption);
                    } else {
                      // Handle case when no option is selected
                      widget.onReportSelected(null);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffF29D38),
                  ),
                  child: Text(
                    'Report',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportOption(String optionText, {String? subtitle}) {
    return ListTile(
      dense: subtitle == null,
      title: Text(
        optionText,
        style: TextStyle(
            color:
                selectedOption == optionText ? Color(0xffF29D38) : Colors.black,
            fontWeight: selectedOption == optionText
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: subtitle != null ? 16.0 : 14.0,
            fontFamily: AppFont.fontMedium),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: selectedOption == optionText
                    ? Color(0xffe5b37d)
                    : Colors.grey,
                fontWeight: selectedOption == optionText
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontFamily: AppFont.fontMedium,
                fontSize: 14.0,
              ),
            )
          : null,
      onTap: () {
        setState(() {
          selectedOption = optionText;
        });
      },
    );
  }
}

void showEulaDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return EulaDialog();
    },
  );
}

class EulaDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Scaffold(
      key: Key('eula_dialog'),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'User License Agreement',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    '''
              Welcome to Medzo!

1. Overview

At Medzo, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, share, and safeguard your information when you interact with our services. Please read this policy carefully to understand our practices.

2. Information Collection

2.1 What Information We Collect

We collect various types of personal information to provide and improve our services. This includes identifiers, personal records, protected classifications, commercial information, biometric information, internet activity, geolocation data, audio, electronic, visual, thermal, olfactory, or similar information, professional or employment-related information, education information, and sensitive personal information.

2.2 Legal Bases for Processing

We process your information based on legal grounds, including your consent, compliance with laws, contractual obligations, protection of rights, and legitimate business interests. In certain situations, we may process information without explicit consent, as outlined in applicable laws.

3. Information Sharing

We may share your information in specific situations such as business transfers or with our affiliates. We ensure that any third parties receiving your information adhere to this Privacy Policy.

4. Third-Party Websites

Our services may contain links to third-party websites. We are not responsible for the safety of your information on these sites. Please review the privacy practices of third parties independently.

5. Social Logins

If you choose to log in using social media accounts, we may access certain profile information. Your privacy settings on social media platforms are governed by their policies.

6. Data Retention and Security

We retain your information for the duration necessary to fulfill purposes outlined in this policy, and we implement security measures to protect your data. However, no method of transmission over the Internet is 100% secure.

7. Minors' Privacy

We do not knowingly collect information from individuals under 18 years of age. If you are a parent or guardian and discover that your child has provided us with personal information, please contact us.

8. Privacy Rights

In regions like Canada, you have certain privacy rights, including access, correction, deletion, and the right to object to processing. You can withdraw your consent at any time.

9. Do-Not-Track Features

Currently, we do not respond to Do-Not-Track signals. If standards change, we will update our practices accordingly.

10. Specific Privacy Rights by Region

Depending on your location, you may have specific privacy rights. Please refer to the corresponding section for detailed information.

11. Updates to This Notice

We may update this Privacy Notice to stay compliant with laws. Check the "Revised" date for the latest version. Material changes will be communicated.

12. Contact Us

If you have questions or concerns about this notice, contact our Data Protection Officer at themedzoteam@gmail.com.

13. Review, Update, or Delete Your Data

To exercise your rights or request information about your data, fill out a data subject access request.

Thank you for trusting Medzo with your information.
                    ''',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 0.5,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await updateUser();
                    Get.back();
                  },
                  child: Text(
                    'I Agree',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    // Get.back();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return MandatoryAgreementDialog();
                      },
                    );

                    Future.delayed(Duration(seconds: 2), () {
                      Get.back();
                    });
                  },
                  child: Text(
                    'I Disagree',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future updateUser() async {
    UserModel? userModel = await AuthApi.instance.getLoggedInUserData();
    if (userModel != null) {
      await UserRepository.getInstance().updateUser(userModel.copyWith(
          isEulaAccepted: true, eulaAcceptedDate: DateTime.now()));
    }
  }
}

class MandatoryAgreementDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Mandatory Agreement',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'You must accept the agreement to use this app.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                letterSpacing: 0.5,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

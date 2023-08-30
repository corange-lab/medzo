import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:medzo/controller/home_controller.dart';
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
    // TODO: implement build
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

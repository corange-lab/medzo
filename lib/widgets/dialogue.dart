import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

Future logoutDialogue(context, controller) {
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
              height: Responsive.height(3.8, context),
            ),
            SizedBox(height: Responsive.height(3, context)),
            Text(
              ConstString.logout,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.darkPrimaryColor,
                    fontFamily: AppFont.fontFamilysemi,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.sp(5, context),
                  ),
            ),
            SizedBox(height: Responsive.height(1.3, context)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                "Are you sure you want to sign out?",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: Responsive.sp(3.8, context),
                    color: AppColors.grey.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.fontFamily,
                    letterSpacing: 0),
              ),
            ),
            SizedBox(height: Responsive.height(3, context)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(20, Responsive.height(7, context)),
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
                              fontSize: Responsive.sp(4, context)),
                    ),
                  ),
                ),
                SizedBox(
                  width: Responsive.width(4, context),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(20, Responsive.height(7, context)),
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
                              fontSize: Responsive.sp(4, context)),
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
            height: Responsive.height(5.5, context),
          ),
          SizedBox(height: Responsive.height(2.5, context)),
          Text(
            titleText,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.darkPrimaryColor,
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.sp(5, context),
                ),
          ),
          SizedBox(height: Responsive.height(0.5, context)),
          TextWidget(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: Responsive.sp(3.7, context),
                color: AppColors.grey.withOpacity(0.9),
                fontWeight: FontWeight.w500,
                fontFamily: AppFont.fontFamily,
                letterSpacing: 0,
                height: 1.5,),
          ),
          SizedBox(height: Responsive.height(2.5, context)),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                fixedSize: Size(Responsive.width(55, context), Responsive.height(7, context)),
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
                  fontSize: Responsive.sp(4.2, context)),
            ),
          ),
        ],
      ),
    );
  }
}

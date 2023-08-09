//Responsive

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/chat/view/widget/widget.dart';
import 'package:medzo/controller/user_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/widgets/custom_widget.dart';

class MyNameTextWidget extends GetWidget<UserController> {
  final TextStyle? textStyle;

  const MyNameTextWidget({this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TextWidget(
          controller.loggedInUser.value.name ?? '',
          style: textStyle ??
              Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 15),
        ));
  }
}

class MyProfilePicWidget extends GetWidget<UserController> {
  final Size? size;

  const MyProfilePicWidget({this.size});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: size?.height ?? 40,
          width: size?.width ?? 40,
          child: ClipOval(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CircularProfileAvatar(
              controller.loggedInUser.value.profilePicture ?? '',
              cacheImage: true,
              animateFromOldImageOnUrlChange: true,
              placeHolder: (context, url) => Container(
                color: AppColors.grey.withOpacity(0.3),
                child: Center(
                  child: Text("MEDZO",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.white,
                          fontFamily: AppFont.fontFamilysemi,
                          fontWeight: FontWeight.w500,
                          fontSize: 8)),
                ),
              ),
              radius: 10,
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColors.primaryColor),
            ),
          ),
        ));
  }
}

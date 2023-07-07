import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/dialogue.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/editprofile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class profile_screen extends StatelessWidget {
  const profile_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.whitehome,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColors.white,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(15),
              child: TextWidget(
                ConstString.profile,
                style: TextStyle(
                  fontSize: Responsive.sp(4.5, context),
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
            ),
            elevation: 2,
            actions: [
              IconButton(
                  onPressed: () async {
                    logoutDialogue(context,controller);
                  },
                  icon: SvgPicture.asset(
                    SvgIcon.signout,
                    height: Responsive.height(2.8, context),
                  ))
            ],
          ),
          body: Column(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: CircleAvatar(
                    maxRadius: Responsive.height(6, context),
                    backgroundColor: AppColors.tilecolor,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              TextWidget(
                "Melissa Jones",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: Responsive.sp(3.8, context),
                      fontFamily: AppFont.fontFamilysemi,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.7,
                      color: const Color(0xFF0D0D0D),
                    ),
              ),
              SizedBox(
                height: Responsive.height(1.5, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "893 Followers",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.sky),
                  ),
                  SizedBox(
                    width: Responsive.width(2, context),
                  ),
                  Container(
                    height: 15,
                    width: 1,
                    color: AppColors.grey.withOpacity(0.2),
                  ),
                  SizedBox(
                    width: Responsive.width(2, context),
                  ),
                  TextWidget(
                    "101 Following",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: AppColors.sky),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height(1.5, context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "Pharmacist @ CVS",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.dark,
                        fontSize: Responsive.sp(2.6, context)),
                  ),
                  SizedBox(
                    width: Responsive.width(1, context),
                  ),
                  SvgPicture.asset(
                    SvgIcon.verify,
                    color: AppColors.blue,
                    height: Responsive.height(1.4, context),
                  )
                ],
              ),
              SizedBox(
                height: Responsive.height(1.5, context),
              ),
              TextWidget(
                "4 year member, 41, Caucasian Female",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: AppColors.grey.withOpacity(0.8),
                    fontSize: Responsive.sp(2.6, context)),
              ),
              SizedBox(
                height: Responsive.height(2, context),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(EditProfileScreen());
                },
                child: TextWidget(
                  ConstString.editprofile,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.black,
                      fontSize: Responsive.sp(3.5, context),
                      fontFamily: AppFont.fontFamilysemi,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    fixedSize: Size(Responsive.width(40, context), 40),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(
                height: Responsive.height(0.8, context),
              ),
              Container(
                height: Responsive.height(14, context),
                width: SizerUtil.width,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: GradientThemeColors.purpleGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x330064B2),
                      blurRadius: 24,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: SvgPicture.asset(
                          AppImages.mobile_image,
                          height: Responsive.height(9, context),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: TextWidget(
                          ConstString.profilesentance,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.white,
                                  fontSize: Responsive.sp(3.3, context),
                                  height: 1.7,
                                  letterSpacing: 0.7,wordSpacing: 0.5),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

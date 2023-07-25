// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/editprofile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.whitehome,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              title: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextWidget(
                    ConstString.profile,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: Responsive.sp(4.8, context),
                        fontFamily: AppFont.fontBold,
                        letterSpacing: 0,
                        color: AppColors.black),
                  ),
                ),
              ),
              elevation: 3,
              shadowColor: AppColors.splashdetail.withOpacity(0.1),
              actions: [
                IconButton(
                    onPressed: () async {
                      logoutDialogue(context, homeController);
                    },
                    icon: SvgPicture.asset(
                      SvgIcon.signout,
                      height: Responsive.height(3, context),
                    ))
              ],
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: controller.dataSnapShot,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ));
                }
                String? name = snapshot.data!.docs[0]['name'];
                String? profession = snapshot.data!.docs[0]['profession'];
                String? imgurl = snapshot.data!.docs[0]['profile_picture'];
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipOval(
                              child: Container(
                                child: imgurl!="" ?
                                Image.network(
                                  imgurl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                            .expectedTotalBytes !=
                                            null
                                            ? loadingProgress
                                            .cumulativeBytesLoaded /
                                            loadingProgress
                                                .expectedTotalBytes!
                                            : null,
                                        color: AppColors.white,
                                        strokeWidth: 3,
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (context, exception, stackTrack) => Icon(
                                    Icons.error,
                                  ),
                                ) :
                                CircleAvatar(backgroundImage: AssetImage(AppImages.profile_picture),radius: 50,),
                                height: 14.h,
                                width: 14.h,
                                color: AppColors.tilecolor,
                              ),
                            ),
                          ),
                        ),
                        TextWidget(
                          "${name}",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontSize: Responsive.sp(4.5, context),
                                    fontFamily: AppFont.fontBold,
                                    letterSpacing: 0,
                                    color: AppColors.darkPrimaryColor,
                                  ),
                        ),
                        SizedBox(
                          height: Responsive.height(2, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              "893 Followers",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: AppColors.sky,
                                      letterSpacing: 0,
                                      fontSize: Responsive.sp(3.8, context)),
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
                                  .copyWith(
                                      color: AppColors.sky,
                                      letterSpacing: 0,
                                      fontSize: Responsive.sp(3.8, context)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.height(2, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              "${profession}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: AppColors.dark,
                                      fontSize: Responsive.sp(3.5, context),
                                      letterSpacing: 0),
                            ),
                            SizedBox(
                              width: Responsive.width(1, context),
                            ),
                            SvgPicture.asset(
                              SvgIcon.verify,
                              color: AppColors.blue,
                              height: Responsive.height(1.8, context),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Responsive.height(2, context),
                        ),
                        TextWidget(
                          "4 year member, 41, Caucasian Female",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: AppColors.grey,
                                  letterSpacing: 0,
                                  fontSize: Responsive.sp(3.5, context)),
                        ),
                        SizedBox(
                          height: Responsive.height(3, context),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(const EditProfileScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize:
                                  Size(Responsive.width(40, context), 48),
                              backgroundColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          child: TextWidget(
                            ConstString.editprofile,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: AppColors.black,
                                  fontSize: Responsive.sp(4, context),
                                  fontFamily: AppFont.fontBold,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: Responsive.height(2, context),
                        ),
                        Container(
                          height: Responsive.height(16, context),
                          width: SizerUtil.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: GradientThemeColors.purpleGradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
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
                                child: SvgPicture.asset(
                                  AppImages.mobile_image,
                                  height: Responsive.height(10, context),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: TextWidget(
                                  ConstString.profilesentance,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: AppColors.white,
                                          fontSize: Responsive.sp(3.8, context),
                                          height: 1.7,
                                          letterSpacing: 0.3,
                                          fontFamily: AppFont.fontFamilysemi,
                                          wordSpacing: 0.3),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      ConstString.nodata,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.black,fontSize: 12),
                    ),
                  );
                }
              },
            ));
      },
    );
  }
}

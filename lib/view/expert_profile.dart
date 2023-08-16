// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/chat_screen.dart';
import 'package:medzo/view/post_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';

class ExpertProfileScreen extends StatelessWidget {
  const ExpertProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              SvgIcon.backarrow,
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  maxRadius: Responsive.height(7, context),
                  backgroundColor: AppColors.tilecolor,
                  backgroundImage: const AssetImage("assets/profile.jpg"),
                ),
              ),
            ),
            TextWidget(
              // FIXME: add User Name
              "Melissa Jones",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                  // FIXME: add User Follower
                  "893 Followers",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                  // FIXME: add Following User
                  "101 Following",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
                  // FIXME: add User Prefession
                  "Pharmacist @ CVS",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
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
              // FIXME: add User Details
              "4 year member, 41, Caucasian Female",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.grey,
                  letterSpacing: 0,
                  fontSize: Responsive.sp(3.5, context)),
            ),
            SizedBox(
              height: Responsive.height(2.5, context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ElevatedButton(
                        onPressed: () {
                          // Get.to( ChatScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(Responsive.width(30, context), 48),
                            backgroundColor: AppColors.splashdetail,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.chat,
                              height: Responsive.height(2.8, context),
                            ),
                            SizedBox(
                              width: Responsive.width(2, context),
                            ),
                            TextWidget(
                              ConstString.chat,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.dark,
                                      fontSize: Responsive.sp(4, context),
                                      fontFamily: AppFont.fontFamilysemi,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(Responsive.width(50, context), 48),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        child: TextWidget(
                          ConstString.follownow,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColors.black,
                                  fontSize: Responsive.sp(4, context),
                                  fontFamily: AppFont.fontFamilysemi,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    ConstString.allpost,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: AppColors.darkPrimaryColor,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          fontSize: Responsive.sp(4.2, context),
                        ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(const PostScreen());
                      },
                      child: Row(
                        children: [
                          TextWidget(
                            ConstString.viewall,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: AppColors.primaryColor,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600,
                                    fontSize: Responsive.sp(3.8, context)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: SvgPicture.asset(
                              SvgIcon.arrowright,
                              height: Responsive.height(2.2, context),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: Responsive.height(35, context),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      horizontalTitleGap: 10,
                      leading: ClipOval(
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          // FIXME: add User Image
                          child: Image.asset("assets/user1.jpg"),
                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                        ),
                      ),
                      // CircleAvatar(
                      //   maxRadius: 22,
                      //   backgroundColor: AppColors.tilecolor,
                      //   child: Icon(
                      //     Icons.person,
                      //     color: AppColors.primaryColor,
                      //   ),
                      // ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          // FIXME: add User Name
                          "Ralph Edwards",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontFamily: AppFont.fontFamilysemi,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                  fontSize: Responsive.sp(4.2, context)),
                        ),
                      ),
                      subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              // FIXME: add Active Timing of User
                              text: "12hr",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey.withOpacity(0.8),
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                            TextSpan(
                              text: "• Updated ✔",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                          ]))),
                      trailing: Obx(
                        () => GestureDetector(
                          onTap: () {
                            if (homeController.isSaveExpert[0]) {
                              homeController.isSaveExpert[0] = false;
                            } else {
                              homeController.isSaveExpert[0] = true;
                            }
                          },
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: homeController.isSaveExpert[0]
                                  ? EdgeInsets.all(7)
                                  : EdgeInsets.all(9),
                              child: SvgPicture.asset(
                                homeController.isSaveExpert[0]
                                    ? SvgIcon.bookmark
                                    : SvgIcon.fillbookmark,
                                height: Responsive.height(2, context),
                                color: homeController.isSaveExpert[0]
                                    ? Colors.black
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        // FIXME: add Medicine Description
                        "Turns out avocados make the best supplements, an article on Vox claimed them to be the best providers for Vitamin C, start bulking up on them! Who cares how expensive they are!?",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Responsive.sp(3.5, context),
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark.withOpacity(0.9),
                            height: 1.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 7,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(14, context),
                                  color: Colors.black12,
                                  child: Image.asset(
                                    // FIXME: add Medicine Image
                                    "assets/frame1.jpg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(14, context),
                                  color: Colors.black12,
                                  child: Image.asset(
                                    // FIXME: add Medicine Image
                                    "assets/frame2.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: Responsive.height(19, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: ClipOval(
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset("assets/user2.jpg"),
                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: AppColors.purple.withOpacity(0.2),
                      //   child: Icon(
                      //     Icons.person,
                      //     color: AppColors.purple.withOpacity(0.7),
                      //   ),
                      // ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Courtney Henry",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontFamily: AppFont.fontBold,
                                  fontSize: Responsive.sp(4.2, context)),
                        ),
                      ),
                      subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "12hr",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey.withOpacity(0.8),
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                            TextSpan(
                              text: "• Updated ✔",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                          ]))),
                      trailing: Obx(() => GestureDetector(
                            onTap: () {
                              if (homeController.isSaveExpert[1]) {
                                homeController.isSaveExpert[1] = false;
                              } else {
                                homeController.isSaveExpert[1] = true;
                              }
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: homeController.isSaveExpert[1]
                                    ? EdgeInsets.all(7.0)
                                    : EdgeInsets.all(9.0),
                                child: SvgPicture.asset(
                                  homeController.isSaveExpert[1]
                                      ? SvgIcon.bookmark
                                      : SvgIcon.fillbookmark,
                                  height: Responsive.height(2, context),
                                  color: homeController.isSaveExpert[1]
                                      ? Colors.black
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Responsive.sp(3.5, context),
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark.withOpacity(0.9),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: Responsive.height(19, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                        leading: ClipOval(
                          child: SizedBox(
                            height: 45,
                            width: 45,
                            child: Image.asset("assets/user3.jpg"),
                            // child: SvgPicture.asset("assets/user.svg",height: 50,),
                          ),
                        ),
                        // CircleAvatar(
                        //   backgroundColor: AppColors.tilecolor,
                        //   child: Icon(
                        //     Icons.person,
                        //     color: AppColors.primaryColor,
                        //   ),
                        // ),
                        title: Align(
                          alignment: Alignment.topLeft,
                          child: TextWidget(
                            "Kristin Watson",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontFamily: AppFont.fontBold,
                                    fontSize: Responsive.sp(4.2, context)),
                          ),
                        ),
                        subtitle: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "12hr",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.grey.withOpacity(0.8),
                                        fontSize: Responsive.sp(3.3, context)),
                              ),
                              TextSpan(
                                text: "• Updated ✔",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.grey,
                                        fontSize: Responsive.sp(3.3, context)),
                              ),
                            ]))),
                        trailing: Obx(
                          () => GestureDetector(
                            onTap: () {
                              if (homeController.isSaveExpert[2]) {
                                homeController.isSaveExpert[2] = false;
                              } else {
                                homeController.isSaveExpert[2] = true;
                              }
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: homeController.isSaveExpert[2]
                                    ? EdgeInsets.all(7.0)
                                    : EdgeInsets.all(9.0),
                                child: SvgPicture.asset(
                                  homeController.isSaveExpert[2]
                                      ? SvgIcon.bookmark
                                      : SvgIcon.fillbookmark,
                                  height: Responsive.height(2, context),
                                  color: homeController.isSaveExpert[2]
                                      ? Colors.black
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Responsive.sp(3.5, context),
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark.withOpacity(0.9),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: Responsive.height(19, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: ClipOval(
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: Image.asset("assets/user4.jpg"),
                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                        ),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: AppColors.purple.withOpacity(0.2),
                      //   child: Icon(
                      //     Icons.person,
                      //     color: AppColors.purple.withOpacity(0.7),
                      //   ),
                      // ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Leslie Alexander",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontFamily: AppFont.fontBold,
                                  fontSize: Responsive.sp(4.2, context)),
                        ),
                      ),
                      subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "12hr",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey.withOpacity(0.8),
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                            TextSpan(
                              text: "• Updated ✔",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                          ]))),
                      trailing: Obx(() => GestureDetector(
                            onTap: () {
                              if (homeController.isSaveExpert[3]) {
                                homeController.isSaveExpert[3] = false;
                              } else {
                                homeController.isSaveExpert[3] = true;
                              }
                            },
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: homeController.isSaveExpert[3]
                                    ? EdgeInsets.all(7.0)
                                    : EdgeInsets.all(9.0),
                                child: SvgPicture.asset(
                                  homeController.isSaveExpert[3]
                                      ? SvgIcon.bookmark
                                      : SvgIcon.fillbookmark,
                                  height: Responsive.height(2, context),
                                  color: homeController.isSaveExpert[3]
                                      ? Colors.black
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Responsive.sp(3.5, context),
                            fontFamily: AppFont.fontFamily,
                            fontWeight: FontWeight.w400,
                            color: AppColors.dark.withOpacity(0.9),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

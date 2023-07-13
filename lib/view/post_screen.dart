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
import 'package:medzo/view/addpost_screen.dart';
import 'package:medzo/view/expert_profile.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.whitedown,
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            // toolbarHeight: Responsive.height(7, context),
            backgroundColor: AppColors.white,
            elevation: 3,
            shadowColor: AppColors.splashdetail.withOpacity(0.1),
            title: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      "Hellow🖐",
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: Responsive.sp(3.8, context),
                          letterSpacing: 0),
                    ),
                    SizedBox(
                      height: Responsive.height(0.5, context),
                    ),
                    TextWidget(
                      "Henry, Arthur",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: Responsive.sp(4.5, context),
                            fontFamily: AppFont.fontBold,
                            letterSpacing: 0,
                            color: AppColors.darkPrimaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              // Padding(
              //   padding: EdgeInsets.all(7),
              //   child: CircleAvatar(
              //     maxRadius: 25,
              //     backgroundColor: Colors.black26,
              //     backgroundImage: AssetImage("assets/user.jpg"),
              //     // child: Icon(
              //     //   Icons.person,
              //     //   color: Colors.black,
              //     // ),
              //   ),
              // ),
              ClipOval(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset("assets/user.jpg"),
                    // child: SvgPicture.asset("assets/user.svg",height: 50,),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const ExpertProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
                      height: Responsive.height(37, context),
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
                              child: TextWidget(
                                "12hr ago",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.grey.withOpacity(0.8),
                                        fontSize: Responsive.sp(3.4, context)),
                              ),
                            ),
                            trailing: Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (controller.isSaveExpert[0]) {
                                    controller.isSaveExpert[0] = false;
                                  } else {
                                    controller.isSaveExpert[0] = true;
                                  }
                                },
                                child: Container(
                                  height: 38,
                                  width: 38,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.splashdetail),
                                  child: Padding(
                                    padding: controller.isSaveExpert[0]
                                        ? EdgeInsets.symmetric(horizontal: 7)
                                        : EdgeInsets.all(9),
                                    child: SvgPicture.asset(
                                      controller.isSaveExpert[0]
                                          ? SvgIcon.bookmark
                                          : SvgIcon.fillbookmark,
                                      height: Responsive.height(2, context),
                                      color: controller.isSaveExpert[0]
                                          ? AppColors.black
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
                              "Turns out avocados make the best supplements, an article on Vox claimed them to be the best providers for Vitamin C, start bulking up on them! Who cares how expensive they are!?",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                                        height: Responsive.height(15, context),
                                        color: Colors.black12,
                                        child: Image.asset(
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
                                        height: Responsive.height(15, context),
                                        color: Colors.black12,
                                        child: Image.asset(
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
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const ExpertProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
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
                                          fontSize:
                                              Responsive.sp(4.2, context)),
                                ),
                              ),
                              subtitle: Align(
                                alignment: Alignment.topLeft,
                                child: TextWidget(
                                  "12hr ago",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color:
                                              AppColors.grey.withOpacity(0.8),
                                          fontSize:
                                              Responsive.sp(3.4, context)),
                                ),
                              ),
                              trailing: Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    if (controller.isSaveExpert[1]) {
                                      controller.isSaveExpert[1] = false;
                                    } else {
                                      controller.isSaveExpert[1] = true;
                                    }
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.splashdetail),
                                    child: Padding(
                                      padding: controller.isSaveExpert[1]
                                          ? EdgeInsets.all(7.0)
                                          : EdgeInsets.all(9),
                                      child: SvgPicture.asset(
                                        controller.isSaveExpert[1]
                                            ? SvgIcon.bookmark
                                            : SvgIcon.fillbookmark,
                                        height: Responsive.height(2, context),
                                        color: controller.isSaveExpert[1]
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const ExpertProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Container(
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
                              child: TextWidget(
                                "12hr ago",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.grey.withOpacity(0.8),
                                        fontSize: Responsive.sp(3.4, context)),
                              ),
                            ),
                            trailing: Obx(() => GestureDetector(
                                  onTap: () {
                                    if (controller.isSaveExpert[2]) {
                                      controller.isSaveExpert[2] = false;
                                    } else {
                                      controller.isSaveExpert[2] = true;
                                    }
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 38,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.splashdetail),
                                    child: Padding(
                                      padding: controller.isSaveExpert[2]
                                          ? EdgeInsets.all(7.0)
                                          : EdgeInsets.all(9.0),
                                      child: SvgPicture.asset(
                                        controller.isSaveExpert[2]
                                            ? SvgIcon.bookmark
                                            : SvgIcon.fillbookmark,
                                        height: Responsive.height(2, context),
                                        color: controller.isSaveExpert[2]
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const ExpertProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Container(
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
                              child: TextWidget(
                                "12hr ago",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.grey.withOpacity(0.8),
                                        fontSize: Responsive.sp(3.4, context)),
                              ),
                            ),
                            trailing: Obx(() => GestureDetector(
                              onTap: () {
                                if (controller.isSaveExpert[3]) {
                                  controller.isSaveExpert[3] = false;
                                } else {
                                  controller.isSaveExpert[3] = true;
                                }
                              },
                              child: Container(
                                height: 38,
                                width: 38,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.splashdetail),
                                child: Padding(
                                  padding: controller.isSaveExpert[3] ? EdgeInsets.all(7.0) : EdgeInsets.all(9.0),
                                  child: SvgPicture.asset(
                                    controller.isSaveExpert[3] ? SvgIcon.bookmark : SvgIcon.fillbookmark,
                                    height: Responsive.height(2, context),
                                    color: controller.isSaveExpert[3] ? Colors.black : AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),)
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextWidget(
                              "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        ConstString.bestmarches,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.darkPrimaryColor,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: Responsive.sp(4.2, context),
                                ),
                      ),
                      TextButton(
                          onPressed: () {},
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
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.splashdetail),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  height: Responsive.height(22, context),
                  alignment: Alignment.center,
                  child: PageView.builder(
                    controller: controller.pageController.value,
                    onPageChanged: (value) {
                      onPageChanged(controller, value);
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(25, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user5.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Brookln Simons",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                              // SizedBox(
                              //   width: Responsive.width(2, context),
                              // ),
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(30, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user6.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Arlene McCoy",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                              // SizedBox(
                              //   width: Responsive.width(2, context),
                              // ),
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(20, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user7.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Theresa Webb",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Responsive.height(2, context),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(20, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user8.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Wade Warren",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                              // SizedBox(
                              //   width: Responsive.width(2, context),
                              // ),
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(30, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user9.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Darrell Steward",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                              // SizedBox(
                              //   width: Responsive.width(2, context),
                              // ),
                              Expanded(
                                child: SizedBox(
                                  width: Responsive.width(20, context),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: SizedBox(
                                          height: 45,
                                          width: 45,
                                          child:
                                              Image.asset("assets/user10.jpg"),
                                          // child: SvgPicture.asset("assets/user.svg",height: 50,),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      TextWidget(
                                        "Jenny Wilson",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(3, context),
                                                fontWeight: FontWeight.w600,
                                                fontFamily: AppFont.fontMedium,
                                                color: AppColors.dark
                                                    .withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                  // color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 2; i++)
                          controller.pageIndex.value == i
                              ? Container(
                                  height: 5,
                                  width: 17,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                )
                              : Container(
                                  height: 5,
                                  width: 6,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        ConstString.bookmarkpost,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: AppColors.darkPrimaryColor,
                                  fontFamily: AppFont.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: Responsive.sp(4.2, context),
                                ),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(const MedicineDetail());
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // onTap: () {
                      //   Get.to(const MedicineDetail());
                      // },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Container(
                          height: Responsive.height(22, context),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.splashdetail),
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: Responsive.width(3, context),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SizedBox(
                                    height: Responsive.height(7, context),
                                    child: Image.asset(AppImages.pill),
                                  ),
                                ),
                                SizedBox(
                                  width: Responsive.width(1, context),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextWidget(
                                        "Azithromycin",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                fontSize:
                                                    Responsive.sp(4, context),
                                                color:
                                                    AppColors.darkPrimaryColor,
                                                fontFamily: AppFont.fontBold,
                                                letterSpacing: 0),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(0.3, context),
                                      ),
                                      TextWidget(
                                        "A fast acting antibiotic.\nTackles infections effectively",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                height: 1.5,
                                                color: AppColors.grey,
                                                fontFamily: AppFont.fontFamily,
                                                fontWeight: FontWeight.w400,
                                                fontSize: Responsive.sp(
                                                    3.2, context)),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(0.5, context),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size:
                                                Responsive.height(2.5, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size:
                                                Responsive.height(2.5, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size:
                                                Responsive.height(2.5, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size:
                                                Responsive.height(2.5, context),
                                          ),
                                          Icon(
                                            Icons.star_outline_rounded,
                                            color: AppColors.primaryColor,
                                            size:
                                                Responsive.height(2.5, context),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                            SvgIcon.pill,
                                            color: AppColors.primaryColor,
                                            height:
                                                Responsive.height(1.8, context),
                                          ),
                                          SizedBox(
                                            width:
                                                Responsive.width(1.5, context),
                                          ),
                                          TextWidget(
                                            ConstString.antibiotic,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontFamily:
                                                      AppFont.fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.2,
                                                  fontSize: Responsive.sp(
                                                      3.2, context),
                                                ),
                                          ),
                                          SizedBox(
                                            width: Responsive.width(3, context),
                                          ),
                                          SvgPicture.asset(
                                            SvgIcon.Rx,
                                            color: AppColors.primaryColor,
                                            height:
                                                Responsive.height(1.6, context),
                                          ),
                                          SizedBox(
                                            width:
                                                Responsive.width(1.5, context),
                                          ),
                                          TextWidget(
                                            ConstString.prescribed,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.2,
                                                  fontSize: Responsive.sp(
                                                      3.2, context),
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(4.4, context),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.to(const MedicineDetail());
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: AppColors
                                                    .splashdetail
                                                    .withOpacity(0.7),
                                                fixedSize: Size(
                                                    Responsive.width(
                                                        43, context),
                                                    0),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 0.5,
                                                        color: AppColors.grey
                                                            .withOpacity(0.1)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextWidget(
                                                  ConstString.viewmoredetails,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Responsive.sp(
                                                                  3.2, context),
                                                          color: AppColors.dark,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: AppFont
                                                              .fontMedium),
                                                ),
                                                SizedBox(
                                                  width: Responsive.width(
                                                      1, context),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_rounded,
                                                  size: Responsive.height(
                                                      1.8, context),
                                                  color: AppColors.dark,
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      if (controller.isSaveMedicine[index]) {
                                        controller.isSaveMedicine[index] =
                                            false;
                                      } else {
                                        controller.isSaveMedicine[index] = true;
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        height: 38,
                                        width: 38,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: AppColors.splashdetail),
                                        child: Padding(
                                          padding:
                                              controller.isSaveMedicine[index]
                                                  ? EdgeInsets.all(8)
                                                  : EdgeInsets.all(10.0),
                                          child: SvgPicture.asset(
                                            controller.isSaveMedicine[index]
                                                ? SvgIcon.bookmark
                                                : SvgIcon.fillbookmark,
                                            height:
                                                Responsive.height(1.8, context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: Responsive.width(1, context),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(const AddpostScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size(Responsive.width(50, context),
                          Responsive.height(7, context)),
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgIcon.add,
                        height: Responsive.sp(4, context),
                      ),
                      SizedBox(
                        width: Responsive.width(3, context),
                      ),
                      TextWidget(
                        ConstString.addpost,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColors.buttontext,
                                fontSize: Responsive.sp(4, context)),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  void onPageChanged(HomeController controller, int? value) {
    controller.pageIndex.value = value ?? 0;
    // print('value $value');
    // if (controller.selectedPageIndex.value == 3) {
    //   navigateToHome();
    // }
  }
}
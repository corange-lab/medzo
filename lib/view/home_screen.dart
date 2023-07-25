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
import 'package:medzo/view/bookmark_screen.dart';
import 'package:medzo/view/category_screen.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/view/message_screen.dart';
import 'package:medzo/view/post_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/view/search_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final FocusNode fNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (controller) {
        if (controller.pageIndex.value == 0) {
          return Scaffold(
            body: Center(
              child: homeWidget(controller, context),
            ),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          );
        } else if (controller.pageIndex.value == 1) {
          return Scaffold(
            body: const PostScreen(),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          );
        } else if (controller.pageIndex.value == 2) {
          return Scaffold(
            body: Center(
              child: Container(
                color: AppColors.whitehome,
                child: const Text("QR"),
              ),
            ),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          );
        } else if (controller.pageIndex.value == 3) {
          return Scaffold(
            body: const BookmarkScreen(),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          );
        }
        return Scaffold(
          body: ProfileScreen(),
          bottomNavigationBar: bottomNavigationBar(controller, context),
        );
      },
    );
  }

  Container homeWidget(HomeController controller, BuildContext context) {
    return Container(
      color: AppColors.whitehome,
      child: Scaffold(
        backgroundColor: AppColors.whitehome,
        appBar: AppBar(
          titleSpacing: 7,
          toolbarHeight: Responsive.height(7, context),
          backgroundColor: AppColors.white,
          elevation: 3,
          shadowColor: AppColors.splashdetail.withOpacity(0.1),
          scrolledUnderElevation: 3,
          leading: ClipOval(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset("assets/user.jpg"),
              ),
            ),
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  "Hellow🖐",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: Responsive.sp(3.8, context), letterSpacing: 0),
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
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const MessageScreen());
                },
                icon: SvgPicture.asset(
                  SvgIcon.chathome,
                  height: Responsive.height(2.8, context),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.to(const SearchScreen());
                    },
                    decoration: InputDecoration(
                      filled: true,
                      enabled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 10),
                        child: SvgPicture.asset(
                          SvgIcon.search,
                          height: Responsive.height(2, context),
                        ),
                      ),
                      fillColor: AppColors.splashdetail,
                      hintText: "Search Drugs, Reviews, and Ratings...",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontFamily: AppFont.fontMedium,
                              fontSize: Responsive.sp(4, context)),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        ConstString.category,
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
                            Get.to(const CategoryScreen());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                ConstString.viewall,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: AppColors.primaryColor,
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
                SizedBox(
                  height: Responsive.height(18, context),
                  child: PageView.builder(
                    controller: controller.pageController.value,
                    onPageChanged: (value) {
                      onPageChanged(controller, value);
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Responsive.width(20, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.painkiller,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.painkillar,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SizedBox(
                                width: Responsive.width(30, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.antidepreset,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.antidepresant,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SizedBox(
                                width: Responsive.width(20, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.antibiotic,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.antibiotic,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
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
                              SizedBox(
                                width: Responsive.width(20, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.hypnotics,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.hypnotics,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SizedBox(
                                width: Responsive.width(30, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.supplements,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.supplements,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SizedBox(
                                width: Responsive.width(20, context),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.alergies,
                                      height: Responsive.height(4.5, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1.3, context),
                                    ),
                                    TextWidget(
                                      ConstString.allergies,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              fontSize:
                                                  Responsive.sp(3, context),
                                              fontFamily: AppFont.fontMedium,
                                              letterSpacing: 0.3,
                                              color: AppColors.grey),
                                    )
                                  ],
                                ),
                                // color: Colors.black12,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 2; i++)
                        controller.pageIndex.value == i
                            ? Container(
                                height: 5.5,
                                width: 18,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container(
                                height: 5.5,
                                width: 5.5,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    color: AppColors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        ConstString.popularmedicine,
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
                            vertical: 5, horizontal: 5),
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
                                                                  3, context),
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
                                                  ? EdgeInsets.all(8.0)
                                                  : EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            controller.isSaveMedicine[index]
                                                ? SvgIcon.bookmark
                                                : SvgIcon.fillbookmark,
                                            height:
                                                Responsive.height(2, context),
                                            color:
                                                controller.isSaveMedicine[index]
                                                    ? Colors.black
                                                    : AppColors.primaryColor,
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
        ),
      ),
    );
  }

  Widget bottomNavigationBar(HomeController controller, BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'PageUpdate',
      builder: (controller) {
        return Container(
          height: Responsive.height(9, context),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                  color: Colors.black12)
            ],
            color: AppColors.white,
          ),
          child: BottomNavigationBar(
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: true,
              currentIndex: controller.pageIndex.value,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(3.2, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: AppColors.primaryColor),
              unselectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(3.2, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                  color: AppColors.grey),
              onTap: (int selectedIndex) {
                controller.pageUpdateOnHomeScreen(selectedIndex);
              },
              showSelectedLabels: true,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: Image.asset(
                        AppImages.logo,
                        color: controller.pageIndex.value == 0
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.8, context),
                      ),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8, left: 5, right: 5, top: 3),
                      child: SvgPicture.asset(
                        SvgIcon.post,
                        color: controller.pageIndex.value == 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(1.9, context),
                      ),
                    ),
                    label: "Post"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 6, left: 5, right: 5),
                      child: SvgPicture.asset(
                        SvgIcon.qrcode,
                        color: controller.pageIndex.value == 2
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.8, context),
                      ),
                    ),
                    label: "QR Code"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: SvgPicture.asset(
                        SvgIcon.bookmark,
                        color: controller.pageIndex.value == 3
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.8, context),
                      ),
                    ),
                    label: "Bookmarks"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                      child: SvgPicture.asset(
                        SvgIcon.profile,
                        color: controller.pageIndex.value == 4
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.8, context),
                      ),
                    ),
                    label: "Profile"),
              ]),
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

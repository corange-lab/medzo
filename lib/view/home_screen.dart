import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/category_screen.dart';
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
          return Container(
            child: Scaffold(
              body: Center(
                child: homeWidget(controller, context),
              ),
              bottomNavigationBar: bottomNavigationBar(controller, context),
            ),
          );
        } else if (controller.pageIndex.value == 1) {
          return Container(
            child: Scaffold(
              body: Center(
                child: Container(
                  color: ThemeColor.whitehome,
                  child: const Text("Post"),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(controller, context),
            ),
          );
        } else if (controller.pageIndex.value == 2) {
          return Container(
            child: Scaffold(
              body: Center(
                child: Container(
                  color: ThemeColor.whitehome,
                  child: const Text("QR"),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(controller, context),
            ),
          );
        } else if (controller.pageIndex.value == 3) {
          return Container(
            child: Scaffold(
              body: Center(
                child: Container(
                  color: ThemeColor.whitehome,
                  child: const Text("Bookmark"),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(controller, context),
            ),
          );
        }
        return Container(
          child: Scaffold(
            body: const profile_screen(),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          ),
        );
      },
    );
  }

  Container homeWidget(HomeController controller, BuildContext context) {
    return Container(
      color: ThemeColor.whitehome,
      child: Scaffold(
        backgroundColor: ThemeColor.whitehome,
        appBar: AppBar(
          toolbarHeight: Responsive.height(7, context),
          backgroundColor: ThemeColor.white,
          elevation: 3,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
            child: CircleAvatar(
              backgroundColor: Colors.black26,
              child: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hellow🖐",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: Responsive.height(0.3, context),
              ),
              Text(
                "Henry, Arthur",
                style: TextStyle(
                  fontSize: Responsive.sp(3.6, context),
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SvgPicture.asset(
                SvgIcon.chathome,
                height: Responsive.height(2.5, context),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      Get.to(search_screen());
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
                      fillColor: AppColors.searchbar,
                      hintText: "Search Drugs, Reviews, and Ratings...",
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColor.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColor.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColor.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ThemeColor.whitehome, width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
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
                        style: TextStyle(
                            fontSize: Responsive.sp(3.4, context),
                            // 35
                            fontFamily: AppFont.fontFamilysemi,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: ThemeColor.darkPrimaryColor),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(category_screen());
                          },
                          child: TextWidget(
                            ConstString.viewall,
                            style: TextStyle(
                                fontSize: Responsive.sp(3.1, context),
                                fontFamily: AppFont.fontFamily,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: ThemeColor.primaryColor),
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
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.painkillar,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.antidepresant,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.antibiotic,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                      AppImages.cardiovascular,
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.cardiovascular,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.supplements,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                      height: Responsive.height(4.2, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    TextWidget(
                                      ConstString.allergies,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.3, context),
                                          fontFamily: AppFont.fontFamily,
                                          color: ThemeColor.grey),
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
                                height: 5,
                                width: 17,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    color: ThemeColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container(
                                height: 5,
                                width: 6,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        ConstString.popularmedicine,
                        style: TextStyle(
                            fontSize: Responsive.sp(3.4, context),
                            // 35
                            fontFamily: AppFont.fontFamilysemi,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            color: ThemeColor.darkPrimaryColor),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: TextWidget(
                            ConstString.viewall,
                            style: TextStyle(
                                fontSize: Responsive.sp(3.1, context),
                                fontFamily: AppFont.fontFamily,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: ThemeColor.primaryColor),
                          ))
                    ],
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Container(
                        height: Responsive.height(18.5, context),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                  color: Colors.black12)
                            ],
                            color: ThemeColor.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Responsive.width(3, context),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SizedBox(
                                  height: Responsive.height(6, context),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Azithromycin",
                                      style: TextStyle(
                                          fontSize: Responsive.sp(3.2, context),
                                          fontFamily: AppFont.fontFamilysemi,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.5),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(0.5, context),
                                    ),
                                    TextWidget(
                                      "A fast acting antibiotic.\nTackles infections effectively",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: Responsive.sp(2.5, context),
                                          fontFamily: AppFont.fontFamily,
                                          height: 1.5,
                                          color: ThemeColor.grey),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: ThemeColor.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: ThemeColor.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: ThemeColor.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: ThemeColor.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_outline_rounded,
                                          color: ThemeColor.primaryColor,
                                          size: Responsive.height(2, context),
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
                                          color: ThemeColor.primaryColor,
                                          height:
                                              Responsive.height(1.5, context),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(1, context),
                                        ),
                                        TextWidget(
                                          ConstString.antibiotic,
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.sp(2.5, context),
                                              color: ThemeColor.primaryColor,
                                              fontFamily: AppFont.fontFamily),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(2, context),
                                        ),
                                        SvgPicture.asset(
                                          SvgIcon.Rx,
                                          color: ThemeColor.primaryColor,
                                          height:
                                              Responsive.height(1.4, context),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(1, context),
                                        ),
                                        TextWidget(
                                          ConstString.prescribed,
                                          style: TextStyle(
                                              fontSize:
                                                  Responsive.sp(2.5, context),
                                              color: ThemeColor.primaryColor,
                                              fontFamily: AppFont.fontFamily),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(3.5, context),
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColors.splashdetail,
                                              fixedSize: Size(
                                                  Responsive.width(40, context),
                                                  0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                ConstString.viewmoredetails,
                                                style: TextStyle(
                                                    fontSize: Responsive.sp(
                                                        2.5, context),
                                                    color: Color(0xff474747),
                                                    fontFamily:
                                                        AppFont.fontFamily),
                                              ),
                                              SizedBox(
                                                width: Responsive.width(
                                                    1, context),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                size: Responsive.height(
                                                    1.8, context),
                                                color: Color(0xff474747),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: SvgPicture.asset(
                                      SvgIcon.bookmark,
                                      height: Responsive.height(2, context),
                                      color: Colors.black,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.splashdetail),
                                ),
                              )
                            ],
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
        return SizedBox(
          height: Responsive.height(8, context),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: false,
              currentIndex: controller.pageIndex.value,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(2.3, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: ThemeColor.primaryColor),
              unselectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(2.3, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: ThemeColor.grey),
              onTap: (int selectedIndex) {
                controller.pageUpdateOnHomeScreen(selectedIndex);
              },
              showSelectedLabels: true,
              elevation: 20,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: Responsive.height(2.3, context),
                        // width: 20,
                        child: Image.asset(
                          AppImages.logo,
                          color: controller.pageIndex.value == 0
                              ? ThemeColor.primaryColor
                              : ThemeColor.grey,
                        ),
                      ),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: SizedBox(
                        height: Responsive.height(1.8, context),
                        child: SvgPicture.asset(
                          SvgIcon.post,
                          color: controller.pageIndex.value == 1
                              ? ThemeColor.primaryColor
                              : ThemeColor.grey,
                        ),
                        // width: 20,
                      ),
                    ),
                    label: "Post"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: Responsive.height(2.3, context),
                        child: SvgPicture.asset(
                          SvgIcon.qrcode,
                          color: controller.pageIndex.value == 2
                              ? ThemeColor.primaryColor
                              : ThemeColor.grey,
                        ),
                        // width: 20,
                      ),
                    ),
                    label: "QR Code"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: Responsive.height(2.3, context),
                        child: SvgPicture.asset(
                          SvgIcon.bookmark,
                          color: controller.pageIndex.value == 3
                              ? ThemeColor.primaryColor
                              : ThemeColor.grey,
                        ),
                        // width: 20,
                      ),
                    ),
                    label: "Bookmarks"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: Responsive.height(2.3, context),
                        child: SvgPicture.asset(
                          SvgIcon.profile,
                          color: controller.pageIndex.value == 4
                              ? ThemeColor.primaryColor
                              : ThemeColor.grey,
                        ),
                        // width: 20,
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

// Scaffold(
// body: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// const Center(child: Text('Home Screen')),
// const SizedBox(height: 40),
// ElevatedButton(
// onPressed: () async {
// await controller.signOut();
// },
// child: Text(
// 'Sign Out',
// style: Theme.of(context).textTheme.labelMedium,
// ),
// ),
// ],
// ))

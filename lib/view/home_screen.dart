import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/chat/view/chat_list_page/chat_list_page.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/addpost_screen.dart';
import 'package:medzo/view/bookmark_screen.dart';
import 'package:medzo/view/category_screen.dart';
import 'package:medzo/view/expert_profile.dart';
import 'package:medzo/view/medicine_detail.dart';
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
            body: Center(
              child: postWidget(controller, context),
            ),
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
          body: const profile_screen(),
          bottomNavigationBar: bottomNavigationBar(controller, context),
        );
      },
    );
  }

  Container postWidget(HomeController controller, BuildContext context) {
    return Container(
      color: AppColors.whitehome,
      child: Scaffold(
        backgroundColor: AppColors.whitedown,
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: Responsive.height(7, context),
          backgroundColor: AppColors.white,
          elevation: 2,
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
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
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontSize: Responsive.sp(3.8, context),
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: const Color(0xFF0D0D0D),
                      ),
                ),
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.black26,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
            ),
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
                    height: Responsive.height(33, context),
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.tilecolor,
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          title: Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              "Ralph Edwards",
                              style: Theme.of(context).textTheme.labelLarge,
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
                                      color: AppColors.grey.withOpacity(0.5)),
                            ),
                          ),
                          trailing: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                SvgIcon.bookmark,
                                height: Responsive.height(2, context),
                                color: Colors.black,
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
                                    color: AppColors.dark.withOpacity(0.5),
                                    height: 1.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: Responsive.height(15, context),
                                      color: Colors.black12,
                                    ),
                                  )),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(15, context),
                                  color: Colors.black12,
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
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Container(
                    height: Responsive.height(17, context),
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.purple.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: AppColors.purple.withOpacity(0.7),
                            ),
                          ),
                          title: Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              "Courtney Henry",
                              style: Theme.of(context).textTheme.labelLarge,
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
                                      color: AppColors.grey.withOpacity(0.5)),
                            ),
                          ),
                          trailing: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                SvgIcon.bookmark,
                                height: Responsive.height(2, context),
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                                    color: AppColors.dark.withOpacity(0.5),
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
                    height: Responsive.height(17, context),
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.tilecolor,
                            child: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          title: Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              "Kristin Watson",
                              style: Theme.of(context).textTheme.labelLarge,
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
                                      color: AppColors.grey.withOpacity(0.5)),
                            ),
                          ),
                          trailing: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                SvgIcon.bookmark,
                                height: Responsive.height(2, context),
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                                    color: AppColors.dark.withOpacity(0.5),
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
                    height: Responsive.height(17, context),
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppColors.purple.withOpacity(0.2),
                            child: Icon(
                              Icons.person,
                              color: AppColors.purple.withOpacity(0.7),
                            ),
                          ),
                          title: Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              "Leslie Alexander",
                              style: Theme.of(context).textTheme.labelLarge,
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
                                      color: AppColors.grey.withOpacity(0.5)),
                            ),
                          ),
                          trailing: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                SvgIcon.bookmark,
                                height: Responsive.height(2, context),
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                                    color: AppColors.dark.withOpacity(0.5),
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
                      style: TextStyle(
                          fontSize: Responsive.sp(3.4, context),
                          // 35
                          fontFamily: AppFont.fontFamilysemi,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: AppColors.darkPrimaryColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          ConstString.viewall,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ))
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: Responsive.height(20, context),
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor:
                                        AppColors.purple.withOpacity(0.2),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.purple.withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Brookln Simons",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor: AppColors.tilecolor,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Arlene McCoy",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor:
                                        AppColors.purple.withOpacity(0.2),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.purple.withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Theresa Webb",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor: AppColors.tilecolor,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Wade Warren",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor:
                                        AppColors.purple.withOpacity(0.2),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.purple.withOpacity(0.7),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Darrell Steward",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                                  CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor: AppColors.tilecolor,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Responsive.height(1, context),
                                  ),
                                  TextWidget(
                                    "Jenny Wilson",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(2.3, context),
                                        fontFamily: AppFont.fontFamily,
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
                      style: TextStyle(
                          fontSize: Responsive.sp(3.4, context),
                          // 35
                          fontFamily: AppFont.fontFamilysemi,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: AppColors.darkPrimaryColor),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          ConstString.viewall,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                    height: 1.4,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Container(
                        height: Responsive.height(18.5, context),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                  color: Colors.black12)
                            ],
                            color: AppColors.white,
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
                                          color: AppColors.grey),
                                    ),
                                    SizedBox(
                                      height: Responsive.height(1, context),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star_rounded,
                                          color: AppColors.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: AppColors.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: AppColors.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_rounded,
                                          color: AppColors.primaryColor,
                                          size: Responsive.height(2, context),
                                        ),
                                        Icon(
                                          Icons.star_outline_rounded,
                                          color: AppColors.primaryColor,
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
                                          color: AppColors.primaryColor,
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
                                              color: AppColors.primaryColor,
                                              fontFamily: AppFont.fontFamily),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(2, context),
                                        ),
                                        SvgPicture.asset(
                                          SvgIcon.Rx,
                                          color: AppColors.primaryColor,
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
                                              color: AppColors.primaryColor,
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
                                                    color:
                                                        const Color(0xff474747),
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
                                                color: const Color(0xff474747),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.splashdetail),
                                  child: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: SvgPicture.asset(
                                      SvgIcon.fillbookmark,
                                      height: Responsive.height(2, context),
                                    ),
                                  ),
                                ),
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
                    fixedSize: Size(Responsive.width(40, context), 45),
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.buttontext,
                      size: Responsive.height(2.8, context),
                    ),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    TextWidget(
                      ConstString.addpost,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: AppColors.buttontext),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Container homeWidget(HomeController controller, BuildContext context) {
    return Container(
      color: AppColors.whitehome,
      child: Scaffold(
        backgroundColor: AppColors.whitehome,
        appBar: AppBar(
          toolbarHeight: Responsive.height(7, context),
          backgroundColor: AppColors.white,
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
              TextWidget(
                "Hellow🖐",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              SizedBox(
                height: Responsive.height(0.3, context),
              ),
              TextWidget(
                "Henry, Arthur",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: Responsive.sp(3.8, context),
                      fontFamily: AppFont.fontFamilysemi,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: AppColors.darkPrimaryColor,
                    ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // Get.to(MessageScreen());
                  Get.to(ChatListPage());
                },
                icon: SvgPicture.asset(
                  SvgIcon.chathome,
                  height: Responsive.height(2.5, context),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                      fillColor: AppColors.searchbar,
                      hintText: "Search Drugs, Reviews, and Ratings...",
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
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
                            color: AppColors.darkPrimaryColor),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(const CategoryScreen());
                          },
                          child: TextWidget(
                            ConstString.viewall,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.primaryColor,
                                  height: 1.4,
                                  fontWeight: FontWeight.w600,
                                ),
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
                            color: AppColors.darkPrimaryColor),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: TextWidget(
                            ConstString.viewall,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppColors.primaryColor,
                                  height: 1.4,
                                  fontWeight: FontWeight.w600,
                                ),
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
                      onTap: () {
                        Get.to(const MedicineDetail());
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Container(
                          height: Responsive.height(18.5, context),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: Offset(1, 1),
                                    color: Colors.black12)
                              ],
                              color: AppColors.white,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        "Azithromycin",
                                        style: TextStyle(
                                            fontSize:
                                                Responsive.sp(3.2, context),
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
                                            fontSize:
                                                Responsive.sp(2.5, context),
                                            fontFamily: AppFont.fontFamily,
                                            height: 1.5,
                                            color: AppColors.grey),
                                      ),
                                      SizedBox(
                                        height: Responsive.height(1, context),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size: Responsive.height(2, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size: Responsive.height(2, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size: Responsive.height(2, context),
                                          ),
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.primaryColor,
                                            size: Responsive.height(2, context),
                                          ),
                                          Icon(
                                            Icons.star_outline_rounded,
                                            color: AppColors.primaryColor,
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
                                            color: AppColors.primaryColor,
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
                                                color: AppColors.primaryColor,
                                                fontFamily: AppFont.fontFamily),
                                          ),
                                          SizedBox(
                                            width: Responsive.width(2, context),
                                          ),
                                          SvgPicture.asset(
                                            SvgIcon.Rx,
                                            color: AppColors.primaryColor,
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
                                                color: AppColors.primaryColor,
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
                                                    Responsive.width(
                                                        40, context),
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
                                                      color: const Color(
                                                          0xff474747),
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
                                                  color:
                                                      const Color(0xff474747),
                                                )
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.splashdetail),
                                    child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SvgPicture.asset(
                                        SvgIcon.bookmark,
                                        height: Responsive.height(2, context),
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
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
        return SizedBox(
          height: Responsive.height(9, context),
          child: BottomNavigationBar(
              backgroundColor: AppColors.white,
              type: BottomNavigationBarType.fixed,
              useLegacyColorScheme: false,
              currentIndex: controller.pageIndex.value,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(2.3, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: AppColors.primaryColor),
              unselectedLabelStyle: TextStyle(
                  fontSize: Responsive.sp(2.3, context),
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: AppColors.grey),
              onTap: (int selectedIndex) {
                controller.pageUpdateOnHomeScreen(selectedIndex);
              },
              showSelectedLabels: true,
              elevation: 20,
              items: [
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        AppImages.logo,
                        color: controller.pageIndex.value == 0
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.3, context),
                      ),
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: SvgPicture.asset(
                        SvgIcon.post,
                        color: controller.pageIndex.value == 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(1.8, context),
                      ),
                    ),
                    label: "Post"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        SvgIcon.qrcode,
                        color: controller.pageIndex.value == 2
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.3, context),
                      ),
                    ),
                    label: "QR Code"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        SvgIcon.bookmark,
                        color: controller.pageIndex.value == 3
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.3, context),
                      ),
                    ),
                    label: "Bookmarks"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        SvgIcon.profile,
                        color: controller.pageIndex.value == 4
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        height: Responsive.height(2.3, context),
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

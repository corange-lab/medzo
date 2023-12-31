// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/bookmark_screen.dart';
import 'package:medzo/view/category_screen.dart';
import 'package:medzo/view/categorywise_medicine.dart';
import 'package:medzo/view/message_screen.dart';
import 'package:medzo/view/post_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/view/search_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_shimmer_widget.dart';
import 'package:medzo/widgets/medicine_widget.dart';
import 'package:medzo/widgets/user/my_name_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  final FocusNode fNode = FocusNode();

  final String LoggedInUser = FirebaseAuth.instance.currentUser!.uid;

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
            body: BookmarkScreen(),
            bottomNavigationBar: bottomNavigationBar(controller, context),
          );
        }
        return Scaffold(
          body: ProfileScreen(LoggedInUser),
          bottomNavigationBar: bottomNavigationBar(controller, context),
        );
      },
    );
  }

  Container homeWidget(HomeController controller, BuildContext context) {
    MedicineController medicineController = Get.put(MedicineController());

    final itemsPerPage = 6;

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
          title: Row(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyProfilePicWidget(size: Size(45, 45))),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: TextWidget(
                        "Hellow🖐",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(fontSize: 14, letterSpacing: 0),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyNameTextWidget()
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(const MessageScreen());
                },
                icon: SvgPicture.asset(
                  SvgIcon.chathome,
                  height: 22,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
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
                            height: 16,
                          ),
                        ),
                        fillColor: AppColors.splashdetail,
                        hintText: "Search Drugs, Reviews, and Ratings...",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontFamily: AppFont.fontMedium, fontSize: 14.5),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 17,
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<List<CategoryDataModel>>(
                    stream: medicineController.fetchCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 175,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 1, // TODO:
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Replace this with your Shimmer placeholder widgets
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                        CircleAvatar(
                                          maxRadius: 25,
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          "Medzo",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        List<CategoryDataModel>? CategoryList = snapshot.data!;
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    ConstString.category,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          color: AppColors.darkPrimaryColor,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                          fontSize: 15.5,
                                        ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(CategoryScreen(CategoryList));
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextWidget(
                                            ConstString.viewall,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: SvgPicture.asset(
                                              SvgIcon.arrowright,
                                              height: 18,
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 160,
                              child: PageView.builder(
                                controller: controller.pageController.value,
                                onPageChanged: (value) {
                                  onPageChanged(controller, value);
                                },
                                itemCount:
                                    (CategoryList.length / itemsPerPage).ceil(),
                                itemBuilder: (context, index) {
                                  int start = index * itemsPerPage;
                                  int end = start + itemsPerPage;
                                  if (end > snapshot.data!.length)
                                    end = snapshot.data!.length;

                                  return GridView.builder(
                                    itemCount: end - start,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 3 / 2,
                                    ),
                                    itemBuilder: (context, gridIndex) {
                                      return InkWell(
                                        onTap: () async {
                                          await Get.to(() =>
                                              CategoryWiseMedicine(
                                                  CategoryList.elementAt(
                                                      (start + gridIndex))));
                                        },
                                        child: SizedBox(
                                          width: 70,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ClipRRect(
                                                child: CachedNetworkImage(
                                                  height: 40,
                                                  imageUrl: CategoryList[
                                                          start + gridIndex]
                                                      .image!,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          SizedBox(
                                                    width: 120,
                                                    child: Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                        color: AppColors
                                                            .primaryColor,
                                                        animating: true,
                                                        radius: 12,
                                                      ),
                                                    ),
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextWidget(
                                                CategoryList[start + gridIndex]
                                                    .name!,
                                                // allCategoryItems[start + gridIndex],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        fontSize: 11.5,
                                                        fontFamily:
                                                            AppFont.fontMedium,
                                                        letterSpacing: 0.3,
                                                        color: AppColors.grey),
                                              )
                                            ],
                                          ),
                                          // color: Colors.black12,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0;
                                      i <
                                          (snapshot.data!.length / itemsPerPage)
                                              .ceil();
                                      i++)
                                    controller.pageIndex.value == i
                                        ? Container(
                                            height: 5.5,
                                            width: 18,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        : Container(
                                            height: 5.5,
                                            width: 5.5,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 2),
                                            decoration: BoxDecoration(
                                                color: AppColors.grey
                                                    .withOpacity(0.3),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          height: 160,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Image.asset(
                                    SvgIcon.nodata,
                                    scale: 0.5,
                                  ),
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ConstString.noCategory,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontFamily: AppFont.fontBold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          ConstString.popularmedicine,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontFamily: AppFont.fontFamily,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                fontSize: 15.5,
                              ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await Get.to(() => BookmarkScreen());
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
                                          fontSize: 14),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: SvgPicture.asset(
                                    SvgIcon.arrowright,
                                    height: 18,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  StreamBuilder<List<Medicine>>(
                    stream: medicineController.fetchPopularMedicine(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return MedicineShimmerWidget();
                      }
                      if (snapshot.hasData) {
                        List<Medicine> medicineDetails = snapshot.data!;

                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: medicineDetails.length,
                          itemBuilder: (context, index) {
                            return MedicineWidget(
                              medicineDetail: medicineDetails.elementAt(index),
                              medicineBindPlace: MedicineBindPlace.dashboard,
                            );
                          },
                        );
                      } else {
                        return Container(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Image.asset(
                                    SvgIcon.nodata,
                                    scale: 0.5,
                                  ),
                                  width: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ConstString.noMedicine,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontFamily: AppFont.fontBold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
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
          height: 70,
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
                  fontSize: 12,
                  fontFamily: AppFont.fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: AppColors.primaryColor),
              unselectedLabelStyle: TextStyle(
                  fontSize: 12,
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
                        height: 22,
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
                        height: 15,
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
                        height: 22,
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
                        height: 22,
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
                        height: 22,
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

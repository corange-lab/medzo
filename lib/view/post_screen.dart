
// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/chat/view/conversation_page/conversations_page.dart';
import 'package:medzo/controller/post_controller.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/addpost_screen.dart';
import 'package:medzo/view/bookmark_screen.dart';
import 'package:medzo/view/image_preview_screen.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/view/post_detail_screen.dart';
import 'package:medzo/view/post_list_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/my_name_text_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class PostScreen extends GetView<PostController> {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.isRegistered<PostController>()
        ? Get.find<PostController>()
        : Get.put(PostController());
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
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 14, letterSpacing: 0),
                ),
                SizedBox(
                  height: 5,
                ),
                MyNameTextWidget()
              ],
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: MyProfilePicWidget(size: Size(45, 45))),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostListWidget(
              streamQuery: controller.fetchDashboardPosts(),
              type: PostFetchType.dashboardPosts,
            ),
            SizedBox(
              height: 10,
            ),
            ...BestMatchesWidget(context),
            SizedBox(
              height: 10,
            ),
            ...BookmarkPostWidget(context),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: ElevatedButton(
              onPressed: () async {
                await Get.to(() => AddPostScreen());
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  fixedSize: Size(160, 48),
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.add,
                    height: 14,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextWidget(
                    ConstString.addpost,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColors.buttontext, fontSize: 14),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void onPageChanged(PostController controller, int? value) {
    controller.pageIndex.value = value ?? 0;
    // print('value $value');
    // if (controller.selectedPageIndex.value == 3) {
    //   navigateToHome();
    // }
  }

  List<Widget> BestMatchesWidget(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              ConstString.bestmarches,
              style: Get.textTheme.displayMedium!.copyWith(
                color: AppColors.darkPrimaryColor,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 15.5,
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    TextWidget(
                      ConstString.viewall,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
      Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppColors.splashdetail),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 170,
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
                        width: 75,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user5.jpg"),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Brookln Simons",
                              // FIXME: add name
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
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
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user6.jpg"),
                                // child: SvgPicture.asset("assets/user.svg",height: 50,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Arlene McCoy",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
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
                        width: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user7.jpg"),
                                // child: SvgPicture.asset("assets/user.svg",height: 50,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Theresa Webb",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
                            )
                          ],
                        ),
                        // color: Colors.black12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user8.jpg"),
                                // child: SvgPicture.asset("assets/user.svg",height: 50,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Wade Warren",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
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
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user9.jpg"),
                                // child: SvgPicture.asset("assets/user.svg",height: 50,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Darrell Steward",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
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
                        width: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.asset("assets/user10.jpg"),
                                // child: SvgPicture.asset("assets/user.svg",height: 50,),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              "Jenny Wilson",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppFont.fontMedium,
                                      color: AppColors.dark.withOpacity(0.5)),
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                controller.pageIndex.value == i
                    ? Container(
                        height: 5,
                        width: 17,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    : Container(
                        height: 5,
                        width: 6,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10)),
                      ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> BookmarkPostWidget(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              ConstString.bookmarkpost,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.darkPrimaryColor,
                    fontFamily: AppFont.fontFamily,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 15.5,
                  ),
            ),
            TextButton(
                onPressed: () async {
                  await Get.to(() => const BookmarkScreen());
                },
                child: Row(
                  children: [
                    TextWidget(
                      ConstString.viewall,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            // onTap: () {
            //   Get.to(const MedicineDetail());
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.splashdetail),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SizedBox(
                          height: 55,
                          child: Image.asset(AppImages.pill),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextWidget(
                              "Azithromycin",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: 14.5,
                                      color: AppColors.darkPrimaryColor,
                                      fontFamily: AppFont.fontBold,
                                      letterSpacing: 0),
                            ),
                            SizedBox(
                              height: 3,
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
                                      fontSize: 11.5),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.star_outline_rounded,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  SvgIcon.pill,
                                  color: AppColors.primaryColor,
                                  height: 14,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                TextWidget(
                                  ConstString.antibiotic,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                        fontSize: 12,
                                      ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  SvgIcon.Rx,
                                  color: AppColors.primaryColor,
                                  height: 14,
                                ),
                                SizedBox(
                                  width: 5,
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
                                        fontSize: 12,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await Get.to(() => const MedicineDetail());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColors.splashdetail
                                          .withOpacity(0.7),
                                      fixedSize: Size(160, 0),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 0.5,
                                              color: AppColors.grey
                                                  .withOpacity(0.1)),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        ConstString.viewmoredetails,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                fontSize: 11,
                                                color: AppColors.dark,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppFont.fontMedium),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
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
                              controller.isSaveMedicine[index] = false;
                            } else {
                              controller.isSaveMedicine[index] = true;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: controller.isSaveMedicine[index]
                                    ? EdgeInsets.all(8)
                                    : EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  controller.isSaveMedicine[index]
                                      ? SvgIcon.bookmark
                                      : SvgIcon.fillbookmark,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    ];
  }
}

class PostItemComponent extends StatelessWidget {
  final PostData postData;
  final PostController controller;

  const PostItemComponent(
      {super.key, required this.postData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(bottom: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfileScreen(postData.creatorId!));
            },
            child: PostHeaderWidget(
                context, postData, controller.findUser(postData.creatorId!)),
          ),
          Container(
            height: 0.18.h,
            width: SizerUtil.width,
            color: AppColors.grey.withOpacity(0.1),
          ),
          GestureDetector(
            onTap: () async {
              controller.currentPostData = postData;
              await Get.to(() => PostDetailScreen())?.whenComplete(() {
                controller.currentPostData = null;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  postData.description ?? '',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      fontFamily: AppFont.fontMedium,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                      color: AppColors.dark.withOpacity(0.9),
                      height: 1.5),
                ),
              ),
            ),
          ),
          (postData.postImages ?? []).isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    height: 160,
                    alignment: Alignment.center,
                    child: CarouselSlider.builder(
                      itemCount: (postData.postImages ?? []).length,
                      itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) =>
                          GestureDetector(
                        onTap: () {
                          if (postData.postImages?.elementAt(index).url !=
                              null) {
                            Get.to(() => ImagePreviewScreen.withUrl(
                                postData.postImages?.elementAt(index).url ?? '',
                                postData,
                                index));
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          // TODO: handle image null an error
                          child: CachedNetworkImage(
                            imageUrl:
                                postData.postImages?.elementAt(index).url ?? '',
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                              width: 120,
                              child: Center(
                                child: CupertinoActivityIndicator(
                                  color: AppColors.primaryColor,
                                  animating: true,
                                  radius: 14,
                                ),
                              ),
                            ),
                            fit: BoxFit.cover,
                          ),
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                        ),
                      ),
                      options: CarouselOptions(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        viewportFraction: 0.96,
                        disableCenter: true,
                        height: 500,
                      ),
                    ),
                  ))
              : SizedBox(),
          Container(
            height: 0.18.h,
            width: SizerUtil.width,
            color: AppColors.grey.withOpacity(0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await controller.addLike(postData);
                  },
                  child: controller.isLiked(postData)
                      ? SvgPicture.asset(
                          SvgIcon.likePost,
                          height: 20,
                          color: AppColors.primaryColor,
                        )
                      : SvgPicture.asset(
                          SvgIcon.likePost,
                          height: 20,
                        ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  postData.likedUsers?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.txtlike,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFont.fontFamily),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    controller.currentPostData = postData;
                    await Get.to(() => PostDetailScreen())?.whenComplete(() {
                      controller.currentPostData = null;
                    });
                  },
                  child: SvgPicture.asset(
                    SvgIcon.commentPost,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  postData.postComments?.length.toString() ?? "0",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.txtlike,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFont.fontFamily),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ListTile PostHeaderWidget(
      BuildContext context, PostData postData, UserModel thisPostUser) {
    return ListTile(
      horizontalTitleGap: 10,
      leading:
          OtherProfilePicWidget(profilePictureUrl: thisPostUser.profilePicture),
      title: Align(
        alignment: Alignment.topLeft,
        child: TextWidget(
          thisPostUser.name ?? '',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              fontSize: 15),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Align(
          alignment: Alignment.topLeft,
          child: TextWidget(
            timeAgo(postData.createdTime ?? DateTime.now()),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grey.withOpacity(0.8), fontSize: 12.5),
          ),
        ),
      ),
    );
  }
}

class PostListWidget extends GetWidget<PostController> {
  final Stream<QuerySnapshot>? streamQuery;

  final PostFetchType type;

  const PostListWidget({super.key, this.streamQuery, required this.type});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamQuery,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  // Replace this with your Shimmer placeholder widgets
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            leading: CircleAvatar(),
                            trailing: Icon(Icons.comment),
                            title: Text("MEDZO"),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whitehome),
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(3),
                  ),
                  Divider(
                    height: 3,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            leading: CircleAvatar(),
                            trailing: Icon(Icons.comment),
                            title: Text("MEDZO"),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whitehome),
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(3),
                  ),
                  Divider(
                    height: 3,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            leading: CircleAvatar(),
                            trailing: Icon(Icons.comment),
                            title: Text("MEDZO"),
                          ),
                        ),
                        Container(
                          height: 12.h,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whitehome),
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(3),
                  ),
                  Divider(
                    height: 3,
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            print('error ${snapshot.error}');
            return Center(
              child: TextWidget(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey.withOpacity(0.8), fontSize: 12.5),
              ),
            );
          }
          if (snapshot.hasData) {
            List<PostData> postDataList = snapshot.data!.docs.map((doc) {
              return PostData.fromMap(doc.data() as Map<String, dynamic>);
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => PostItemWidget(context,
                        controller, postDataList.elementAt(index), index),
                    separatorBuilder: (context, index) =>
                        Divider(color: Colors.transparent),
                    itemCount: itemCount(postDataList)),
                getBottomWidget(postDataList, context)
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      SvgIcon.nodata,
                      scale: 0.5,
                    ),
                    width: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ConstString.nodata,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 18,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget getBottomWidget(List<PostData> postDataList, BuildContext context) {
    if (type == PostFetchType.userPosts || type == PostFetchType.allPosts) {
      return SizedBox();
    }
    return postDataList.length > 3
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    await Get.to(() => PostListScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: Size(150, 45),
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: TextWidget(
                    ConstString.morePosts,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: AppColors.buttontext, fontSize: 12.sp),
                  )),
            ),
          )
        : SizedBox();
  }

  int itemCount(List<PostData> postDataList) {
    if (type == PostFetchType.allPosts) {
      return postDataList.length;
    } else if (type == PostFetchType.dashboardPosts) {
      return postDataList.length < 3 ? postDataList.length : 3;
    } else if (type == PostFetchType.userPosts) {
      return postDataList.length;
    }
    return postDataList.length;
  }

  Widget PostItemWidget(BuildContext context, PostController controller,
      PostData postData, int index) {
    return GetBuilder<PostController>(
        id: postData.id ?? 'post${postData.id}',
        builder: (ctrl) {
          return PostItemComponent(postData: postData, controller: controller);
        });
  }
}

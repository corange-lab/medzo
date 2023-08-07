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
import 'package:medzo/utils/responsive.dart';
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
    PostController controller = Get.isRegistered<PostController>()
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
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: TextWidget(
                    "Hellow🖐",
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: Responsive.sp(3.8, context),
                        letterSpacing: 0),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(0.5, context),
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
            PostListWidget(context),
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
                  fixedSize: Size(Responsive.width(45, context),
                      Responsive.height(6, context)),
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.add,
                    height: Responsive.sp(3.8, context),
                  ),
                  SizedBox(
                    width: Responsive.width(2, context),
                  ),
                  TextWidget(
                    ConstString.addpost,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: AppColors.buttontext,
                        fontSize: Responsive.sp(3.8, context)),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget PostItemWidget(BuildContext context, PostController controller,
      PostData postData, int index) {
    return GetBuilder<PostController>(
        id: postData.id ?? 'post${postData.id}',
        builder: (ctrl) {
          return GestureDetector(
            // onTap: () async {
            //   controller.currentPostData = postData;
            //   await Get.to(() => PostDetailScreen())?.whenComplete(() {
            //     controller.currentPostData = null;
            //   });
            // },
            child: Container(
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
                    child: PostHeaderWidget(context, postData,
                        controller.findUser(postData.creatorId!)),
                  ),
                  Container(
                    height: 0.18.h,
                    width: SizerUtil.width,
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextWidget(
                        postData.description ?? '',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: Responsive.sp(3.8, context),
                            fontFamily: AppFont.fontMedium,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: AppColors.dark.withOpacity(0.9),
                            height: 1.5),
                      ),
                    ),
                  ),
                  (postData.postImages ?? []).isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Container(
                            height: 20.h,
                            alignment: Alignment.center,
                            child: CarouselSlider.builder(
                              itemCount: (postData.postImages ?? []).length,
                              itemBuilder: (BuildContext context, int index,
                                      int pageViewIndex) =>
                                  GestureDetector(
                                onTap: () {
                                  if (postData.postImages
                                          ?.elementAt(index)
                                          .url !=
                                      null) {
                                    Get.to(() => ImagePreviewScreen.withUrl(
                                        postData.postImages
                                                ?.elementAt(index)
                                                .url ??
                                            '',
                                        postData,
                                        index));
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  // TODO: handle image null an error
                                  child: CachedNetworkImage(
                                    imageUrl: postData.postImages
                                            ?.elementAt(index)
                                            .url ??
                                        '',
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            SizedBox(
                                      width: 120,
                                      child: Center(
                                        child: CupertinoActivityIndicator(
                                          color: AppColors.primaryColor,
                                          animating: true,
                                          radius: 14,
                                        ),
                                      ),
                                    ),
                                    fit: BoxFit.fill,
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
                                  height: 2.4.h,
                                  color: AppColors.primaryColor,
                                )
                              : SvgPicture.asset(
                                  SvgIcon.likePost,
                                  height: 2.4.h,
                                ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          postData.likedUsers?.length.toString() ?? "0",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.txtlike,
                                  letterSpacing: 0.3,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFont.fontFamily),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        GestureDetector(
                          onTap: () async {
                            controller.currentPostData = postData;
                            await Get.to(() => PostDetailScreen())
                                ?.whenComplete(() {
                              controller.currentPostData = null;
                            });
                          },
                          child: SvgPicture.asset(
                            SvgIcon.commentPost,
                            height: 2.5.h,
                          ),
                        ),
                        SizedBox(
                          width: 1.5.w,
                        ),
                        Text(
                          postData.postComments?.length.toString() ?? "0",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.txtlike,
                                  letterSpacing: 0.3,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
              fontSize: Responsive.sp(4.2, context)),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 2),
        child: Align(
          alignment: Alignment.topLeft,
          child: TextWidget(
            timeAgo(postData.createdTime ?? DateTime.now()),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.grey.withOpacity(0.8),
                fontSize: Responsive.sp(3.4, context)),
          ),
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
                fontSize: Responsive.sp(
                    4.2, context), // TODO: remove font size in responsive
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
            border: Border.all(width: 1, color: AppColors.splashdetail),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Brookln Simons",
                              // FIXME: add name
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
                        width: Responsive.width(30, context),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Arlene McCoy",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
                        width: Responsive.width(20, context),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Theresa Webb",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Wade Warren",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
                        width: Responsive.width(30, context),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Darrell Steward",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
                        width: Responsive.width(20, context),
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
                              height: Responsive.height(1, context),
                            ),
                            TextWidget(
                              "Jenny Wilson",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
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
          padding: const EdgeInsets.all(8.0),
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
                    fontSize: Responsive.sp(4.2, context),
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
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            // onTap: () {
            //   Get.to(const MedicineDetail());
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Container(
                height: Responsive.height(22, context),
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
                                      fontSize: Responsive.sp(4, context),
                                      color: AppColors.darkPrimaryColor,
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
                                      fontSize: Responsive.sp(3.2, context)),
                            ),
                            SizedBox(
                              height: Responsive.height(0.5, context),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2.5, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2.5, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2.5, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2.5, context),
                                ),
                                Icon(
                                  Icons.star_outline_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2.5, context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Responsive.height(1, context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  SvgIcon.pill,
                                  color: AppColors.primaryColor,
                                  height: Responsive.height(1.8, context),
                                ),
                                SizedBox(
                                  width: Responsive.width(1.5, context),
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
                                        fontSize: Responsive.sp(3.2, context),
                                      ),
                                ),
                                SizedBox(
                                  width: Responsive.width(3, context),
                                ),
                                SvgPicture.asset(
                                  SvgIcon.Rx,
                                  color: AppColors.primaryColor,
                                  height: Responsive.height(1.6, context),
                                ),
                                SizedBox(
                                  width: Responsive.width(1.5, context),
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
                                        fontSize: Responsive.sp(3.2, context),
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
                                  onPressed: () async {
                                    await Get.to(() => const MedicineDetail());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColors.splashdetail
                                          .withOpacity(0.7),
                                      fixedSize: Size(
                                          Responsive.width(43, context), 0),
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
                                                fontSize:
                                                    Responsive.sp(3.2, context),
                                                color: AppColors.dark,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppFont.fontMedium),
                                      ),
                                      SizedBox(
                                        width: Responsive.width(1, context),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: Responsive.height(1.8, context),
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
                                  height: Responsive.height(1.8, context),
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
    ];
  }

  Widget PostListWidget(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.fetchAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // TODO: shimmer loading for 3 items in list
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
                    itemCount:
                        postDataList.length < 3 ? postDataList.length : 3),
                postDataList.length > 3
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
                                  fixedSize: Size(Responsive.width(40, context),
                                      Responsive.height(5.5, context)),
                                  backgroundColor: AppColors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: TextWidget(
                                ConstString.morePosts,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: AppColors.buttontext,
                                        fontSize: 12.sp),
                              )),
                        ),
                      )
                    : SizedBox()
              ],
            );
          } else {
            // TODO: show No Post data found
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      SvgIcon.nodata,
                      scale: 0.5,
                    ),
                    width: 20.w,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    ConstString.nodata,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 15.sp,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ),
            );
          }
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/post_controller.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/image_preview_screen.dart';
import 'package:medzo/view/post_detail_screen.dart';
import 'package:medzo/view/post_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:sizer/sizer.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    // this screen will have all post from the firestore database collection same as PostScreen Have
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              SvgIcon.backarrow,
              height: 15,
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.postlist,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17.5,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: PostListWidget(
          streamQuery: controller.fetchAllPosts(),
          type: PostFetchType.allPosts,
        ),
      ),
    );
  }

  // PostItemWidget No used everywhere
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
                      // Get.to(() =>
                      //     UserProfileScreen(targetUserId: postData.creatorId!));
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
                                    fit: BoxFit.cover,
                                  ),
                                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                                ),
                              ),
                              options: CarouselOptions(
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                aspectRatio: 16 / 9,
                                enlargeCenterPage: true,
                                viewportFraction: 0.95,
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
              fontSize: 15),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.topLeft,
        child: TextWidget(
          timeAgo(postData.createdTime ?? DateTime.now()),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColors.grey.withOpacity(0.8), fontSize: 13.5),
        ),
      ),
    );
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()}${(diff.inDays / 365).floor() == 1 ? " year" : " years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()}${(diff.inDays / 30).floor() == 1 ? " month" : " months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()}${(diff.inDays / 7).floor() == 1 ? " week" : " weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays}${diff.inDays == 1 ? " day" : " days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours}${diff.inHours == 1 ? " h" : " h"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes}${diff.inMinutes == 1 ? " min" : " min"} ago";
    }
    return "just now";
  }
}

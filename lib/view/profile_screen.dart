// Responsive
// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/post_controller.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/model/user_relationship.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/chat_screen.dart';
import 'package:medzo/view/editprofile_screen.dart';
import 'package:medzo/view/follow_users_screen.dart';
import 'package:medzo/view/post_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;
  final PostController postController =
      Get.put<PostController>(PostController());

  ProfileScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(userId),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.whitehome,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              titleSpacing: 0,
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: FirebaseAuth.instance.currentUser!.uid == userId
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextWidget(
                          ConstString.profile,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontSize: 17.5,
                                  fontFamily: AppFont.fontBold,
                                  letterSpacing: 0,
                                  color: AppColors.black),
                        ),
                      ),
                    )
                  : TextWidget(
                      controller.user.value.name ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 17.5,
                          fontFamily: AppFont.fontBold,
                          letterSpacing: 0,
                          color: AppColors.black),
                    ),
              elevation: 3,
              shadowColor: AppColors.splashdetail.withOpacity(0.1),
              actions: [
                Visibility(
                  visible: FirebaseAuth.instance.currentUser!.uid == userId,
                  child: IconButton(
                      onPressed: () async {
                        logoutDialogue(context);
                      },
                      icon: SvgPicture.asset(
                        SvgIcon.signout,
                        height: 25,
                      )),
                )
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

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ClipOval(
                              child: Container(
                                child: controller.user.value.profilePicture ==
                                        null
                                    ? AppWidget.noProfileWidget(context)
                                    : Image.network(
                                        controller.user.value.profilePicture ??
                                            '',
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
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
                                            (context, exception, stackTrack) =>
                                                Icon(
                                          Icons.error,
                                        ),
                                      ),
                                height: 110,
                                width: 110,
                                color: AppColors.tilecolor,
                              ),
                            ),
                          ),
                        ),
                        TextWidget(controller.user.value.name ?? '-',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  fontSize: 17,
                                  fontFamily: AppFont.fontBold,
                                  letterSpacing: 0,
                                  color: AppColors.darkPrimaryColor,
                                )),
                        SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: controller.user.value.profession != null &&
                              controller.user.value.profession!.isNotEmpty,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextWidget(
                                "${controller.user.value.profession ?? '-'}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: AppColors.dark,
                                        fontSize: 13,
                                        letterSpacing: 0),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                SvgIcon.verify,
                                color: AppColors.blue,
                                height: 15,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FollowFollowingWidget(context, controller),
                        SizedBox(
                          height: 15,
                        ),
                        FirebaseAuth.instance.currentUser!.uid == userId
                            ? ElevatedButton(
                                onPressed: () async {
                                  await Get.to(() =>
                                      EditProfileScreen(controller.user.value));
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    fixedSize: Size(150, 48),
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: TextWidget(
                                  ConstString.editprofile,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: AppColors.black,
                                        fontSize: 15,
                                        fontFamily: AppFont.fontBold,
                                      ),
                                ),
                              )
                            : userFollowActions(controller),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 125,
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
                                  height: 80,
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
                                          fontSize: 13.5,
                                          height: 1.7,
                                          letterSpacing: 0.3,
                                          fontFamily: AppFont.fontFamilysemi,
                                          wordSpacing: 0.3),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        PostListWidget(
                          streamQuery: postController.streamUserPosts(userId),
                          type: PostFetchType.userPosts,
                        ),
                      ],
                    ),
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
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          ConstString.nouser,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.black,
                                  fontSize: 15.sp,
                                  fontFamily: AppFont.fontBold),
                        ),
                      ],
                    ),
                  );
                }
              },
            ));
      },
    );
  }

  StreamBuilder<bool> userFollowActions(ProfileController controller) {
    return StreamBuilder<bool>(
      stream: controller.isFollowingStream,
      initialData: false,
      builder: (context, snapshot) {
        final isFollowing = snapshot.data ?? false;
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            FirebaseAuth.instance.currentUser!.uid != userId
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(const ChatScreen());
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(150, 48),
                                  backgroundColor: AppColors.splashdetail,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    SvgIcon.chat,
                                    height: 22,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextWidget(
                                    ConstString.chat,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: AppColors.dark,
                                            fontSize: 15,
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
                              onPressed: () async {
                                if (isFollowing) {
                                  await controller.unfollowUser(userId);
                                } else {
                                  await controller.followUser(userId);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(150, 48),
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: TextWidget(
                                isFollowing
                                    ? ConstString.unfollow
                                    : ConstString.follownow,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        color: AppColors.black,
                                        fontSize: 15,
                                        fontFamily: AppFont.fontFamilysemi,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        );
      },
    );
  }

  Widget FollowFollowingWidget(
      BuildContext context, ProfileController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<List<UserRelationship>>(
          stream: controller.streamFollowers(userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox();
            }
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                color: AppColors.primaryColor,
                animating: true,
                radius: 10,
              );
            }
            final followers = snapshot.data!;
            return GestureDetector(
              onTap: () async {
                await Get.to(() => FollowUsersScreen(userId: userId));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '${followers.length} Followers',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.sky, letterSpacing: 0, fontSize: 14),
                  ),
                  // for (UserRelationship follower in followers)
                  //   Text(
                  //       'Follower: ${follower.userId}, Timestamp: ${follower.timestamp}'),
                ],
              ),
            );
          },
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 15,
          width: 1,
          color: AppColors.grey.withOpacity(0.2),
        ),
        SizedBox(
          width: 10,
        ),
        StreamBuilder<List<UserRelationship>>(
          stream: controller.streamFollowing(userId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return SizedBox();
            }
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                color: AppColors.primaryColor,
                animating: true,
                radius: 10,
              );
            }
            final following = snapshot.data!;
            return GestureDetector(
              onTap: () async {
                await Get.to(() => FollowUsersScreen(userId: userId));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    '${following.length} Following',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: AppColors.sky, letterSpacing: 0, fontSize: 14),
                  ),
                  // for (UserRelationship followedUser in following)
                  //   Text(
                  //       'Following: ${followedUser.userId}, Timestamp: ${followedUser.timestamp}'),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class AppWidget {
  static Widget noProfileWidget(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImages.profile_picture),
              radius: 50,
              backgroundColor: AppColors.tilecolor,
            ),
          ),
        ),
      ],
    );
  }
}

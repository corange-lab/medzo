import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/user_relationship.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/string.dart';

class FollowUsersScreen extends StatelessWidget {
  final String? userId;

  FollowUsersScreen({super.key, required this.userId});

  ProfileController controller =
      Get.put(ProfileController(FirebaseAuth.instance.currentUser!.uid));
  AllUserController allUserController = Get.put(AllUserController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.white,
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
              controller.allUserController
                      .findSingleUserFromAllUser(userId!)
                      .name ??
                  '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 17.5,
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
          elevation: 3,
          shadowColor: AppColors.splashdetail.withOpacity(0.1),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Followers',
                height: 40,
                // icon: Icon(Icons.people),
              ),
              Tab(
                text: 'Following',
                height: 40,
                // icon: Icon(Icons.person_add_alt_1_outlined)
              ),
              Tab(
                text: 'Blocked',
                height: 40,
                // icon: Icon(Icons.person_add_alt_1_outlined)
              ),
            ],
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            physics: const BouncingScrollPhysics(),
            labelColor: AppColors.primaryColor,
            labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 13.5,
                letterSpacing: 0.3,
                fontFamily: AppFont.fontFamilysemi),
            unselectedLabelColor: AppColors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
                    fontSize: 14,
                    letterSpacing: 0.3,
                    fontFamily: AppFont.fontFamilysemi),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.tilecolor,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            FollowersScreen(userId: userId!),
            FollowingScreen(userId: userId!),
            BlockedUserScreen(userId: userId!),
          ],
        ),
      ),
    );
  }
}

class FollowersScreen extends GetWidget<ProfileController> {
  final String userId;

  const FollowersScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserRelationship>>(
      stream: controller.streamFollowers(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 7, // TODO:
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // Replace this with your Shimmer placeholder widgets
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(),
                                    trailing: Icon(Icons.account_circle),
                                    title: Text("MEDZO"),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(3),
                          ),
                          Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  )));
        }
        if (snapshot.hasData && snapshot.data!.length > 0) {
          return RefreshIndicator(
            color: AppColors.primaryColor,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel user = controller.allUserController
                    .findSingleUserFromAllUser(snapshot.data![index].userId);
                return ListTile(
                  leading: OtherProfilePicWidget(
                      profilePictureUrl: user.profilePicture),
                  title: Text(
                    user.name ?? '',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: AppFont.fontFamilysemi, fontSize: 15),
                  ),
                  subtitle: Text(
                    user.profession ?? '-',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: AppFont.fontMedium,
                          letterSpacing: 0.3,
                          fontSize: 12.5,
                        ),
                  ),
                  // trailing: snapshot.data![index].isFollowing
                  //     ? TextButton(
                  //         onPressed: () {
                  //           controller.unfollowUser(
                  //               snapshot.data![index].id);
                  //         },
                  //         child: Text('Unfollow'),
                  //       )
                  //     : TextButton(
                  //         onPressed: () {
                  //           controller.followUser(snapshot.data![index].id);
                  //         },
                  //         child: Text('Follow'),
                  //       ),
                );
              },
            ),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
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
                  ConstString.noFollower,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontSize: 18,
                      fontFamily: AppFont.fontBold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class FollowingScreen extends GetWidget<ProfileController> {
  final String userId;

  const FollowingScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserRelationship>>(
      stream: controller.streamFollowing(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 7, // TODO:
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // Replace this with your Shimmer placeholder widgets
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(),
                                    trailing: Icon(Icons.account_circle),
                                    title: Text("MEDZO"),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(3),
                          ),
                          Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  )));
        }
        if (snapshot.hasData && snapshot.data!.length > 0) {
          return RefreshIndicator(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserModel user = controller.allUserController
                    .findSingleUserFromAllUser(snapshot.data![index].userId);
                return ListTile(
                  leading: OtherProfilePicWidget(
                      profilePictureUrl: user.profilePicture),
                  title: Text(
                    user.name ?? '',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: AppFont.fontFamilysemi, fontSize: 15),
                  ),
                  subtitle: Text(
                    user.profession ?? '-',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontFamily: AppFont.fontMedium,
                          fontSize: 12.5,
                        ),
                  ),
                );
              },
            ),
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 2));
            },
            color: AppColors.primaryColor,
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
                  ConstString.noFollowing,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontSize: 18,
                      fontFamily: AppFont.fontBold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class BlockedUserScreen extends GetWidget<AllUserController> {
  final String userId;

  const BlockedUserScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: controller.getBlockedUserIds(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 7, // TODO:
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // Replace this with your Shimmer placeholder widgets
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(),
                                    trailing: Icon(Icons.account_circle),
                                    title: Text("MEDZO"),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(3),
                          ),
                          Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  )));
        }
        if (snapshot.hasData && snapshot.data!.length > 0) {
          List<String> ids = snapshot.data!;

          return FutureBuilder(
            future: controller.fetchUsersByIds(ids),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator();
              } else if (snapshot.hasData) {
                List<UserModel> blockedUsers = snapshot.data!;
                return RefreshIndicator(
                  child: ListView.builder(
                    itemCount: blockedUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: OtherProfilePicWidget(
                            profilePictureUrl:
                                blockedUsers[index].profilePicture),
                        title: Text(
                          blockedUsers[index].name ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  fontFamily: AppFont.fontFamilysemi,
                                  fontSize: 15),
                        ),
                        subtitle: Text(
                          blockedUsers[index].profession ?? '-',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontFamily: AppFont.fontMedium,
                                    fontSize: 12.5,
                                  ),
                        ),
                        trailing: TextButton(
                            onPressed: () async {
                              await controller.unblockUser(
                                  userId, blockedUsers[index].id!);
                            },
                            child: Text(
                              "Unblock",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: AppColors.red, fontSize: 13),
                            )),
                      );
                    },
                  ),
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 2));
                  },
                  color: AppColors.primaryColor,
                );
              } else {
                return Text(
                  "No User Found!",
                  style: Theme.of(context).textTheme.titleMedium,
                );
              }
            },
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
                  ConstString.noBlocked,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontSize: 18,
                      fontFamily: AppFont.fontBold),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

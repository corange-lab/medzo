import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/user_relationship.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';

class FollowUsersScreen extends GetWidget<ProfileController> {
  final String userId;

  const FollowUsersScreen({super.key, required this.userId});

  // this screen will have two tabs one is followers and other is following for specific user, where user can follow unfollow from the following screen
  @override
  Widget build(BuildContext context) {
    // create two tab screen for followers and following
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                height: Responsive.height(2, context),
              )),
          title: Align(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              controller.allUserController
                      .findSingleUserFromAllUser(userId)
                      .name ??
                  '',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: Responsive.sp(4.8, context),
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
          elevation: 3,
          shadowColor: AppColors.splashdetail.withOpacity(0.1),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Followers', icon: Icon(Icons.people),),
              Tab(
                  text: 'Following',
                  icon: Icon(Icons.person_add_alt_1_outlined)),
            ],
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3.0),
              insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            labelColor: AppColors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.black,
          ),
        ),
        body: TabBarView(
          children: [
            FollowersScreen(userId: userId),
            FollowingScreen(userId: userId),
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
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel user = controller.allUserController
                  .findSingleUserFromAllUser(snapshot.data![index].userId);
              return ListTile(
                leading: OtherProfilePicWidget(
                    profilePictureUrl: user.profilePicture),
                title: Text(
                  user.name ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  user.profession ?? '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
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
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              UserModel user = controller.allUserController
                  .findSingleUserFromAllUser(snapshot.data![index].userId);
              return ListTile(
                leading: OtherProfilePicWidget(
                    profilePictureUrl: user.profilePicture),
                title: Text(
                  user.name ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  user.profession ?? '-',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/controller/post_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/addpost_screen.dart';
import 'package:medzo/view/bestMatchesScreen.dart';
import 'package:medzo/view/image_preview_screen.dart';
import 'package:medzo/view/post_detail_screen.dart';
import 'package:medzo/view/post_list_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_shimmer_widget.dart';
import 'package:medzo/widgets/medicine_widget.dart';
import 'package:medzo/widgets/user/my_name_text_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class PostScreen extends GetView<PostController> {
  final Function(int, [String]) switchTab;

  PostScreen(this.switchTab);

  @override
  Widget build(BuildContext context) {
    MedicineController medicineController = Get.put(MedicineController());

    AllUserController userController = Get.put(AllUserController());

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
                  "Hello🖐",
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
            BestMatchesWidget(context, userController),
            SizedBox(
              height: 10,
            ),
            ...BookmarkPostWidget(context, medicineController),
            SizedBox(
              height: 60,
            )
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
  }

  StreamBuilder<Object?> BestMatchesWidget(
      BuildContext context, AllUserController userController) {
    final itemsPerPage = 6;
    UserModel? currentUser = userController.currentUser;
    return StreamBuilder<List<UserModel>>(
      stream: userController.fetchMatchesUser(currentUser?.profession ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 195,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          List<UserModel> userData = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      ConstString.bestMatches,
                      style: Get.textTheme.displayMedium!.copyWith(
                        color: AppColors.darkPrimaryColor,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        fontSize: 15.5,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => BestMatchesScreen(userData));
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
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.splashdetail),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: userData.length > 3 ? 22.h : 12.h,
                alignment: Alignment.center,
                child: PageView.builder(
                  controller: controller.pageController.value,
                  onPageChanged: (value) {
                    onPageChanged(controller, value);
                  },
                  itemCount: (userData.length / itemsPerPage).ceil(),
                  itemBuilder: (context, index) {
                    int start = index * itemsPerPage;
                    int end = start + itemsPerPage;

                    if (end > snapshot.data!.length) {
                      end = snapshot.data!.length;
                    }

                    return GridView.builder(
                      itemCount: end - start,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, gridIndex) {
                        UserModel user = userData[start + gridIndex];
                        return GestureDetector(
                          onTap: () {
                            // switchTab(3, user.id!);
                            Get.to(() => ProfileScreen(user.id!));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OtherProfilePicWidget(
                                  profilePictureUrl: user.profilePicture,
                                  size: Size(45, 45)),
                              SizedBox(
                                height: 10,
                              ),
                              TextWidget(
                                "${user.name ?? "Medzo User"}",
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
                        );
                      },
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
                      for (int i = 0;
                          i < (snapshot.data!.length / itemsPerPage).ceil();
                          i++)
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
                                    color: AppColors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColors.splashdetail),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Column(
              children: [
                Icon(CupertinoIcons.person_circle,
                    color: AppColors.primaryColor, size: 45),
                SizedBox(height: 10),
                Text(
                  ConstString.noMatchesUser,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.black,
                      fontSize: 15,
                      fontFamily: AppFont.fontBold),
                ),
              ],
            )),
          );
        }
      },
    );
  }

  List<Widget> BookmarkPostWidget(
      BuildContext context, MedicineController medicineController) {
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
                  switchTab(2);
                  // await Get.to(() => BookmarkScreen());
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
      StreamBuilder<List<Medicine>>(
        stream: medicineController.fetchFavouriteMedicine(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MedicineShimmerWidget(
              itemCount: 2,
              height: 400,
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Medicine> medicineDetails = snapshot.data!;

            if (medicineDetails.isEmpty) {
              return Container();
            }
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 2));
                  },
                  color: AppColors.primaryColor,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: medicineDetails.length >= 2 ? 2 : 1,
                    itemBuilder: (context, index) {
                      return MedicineWidget(
                        medicineDetail: medicineDetails.elementAt(index),
                        medicineBindPlace: MedicineBindPlace.bookmark,
                      );
                    },
                  ),
                ));
          } else {
            return Container(
              height: 20.h,
              alignment: Alignment.center,
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: 1, color: AppColors.splashdetail),
                  borderRadius: BorderRadius.circular(5)),
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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontSize: 14,
                          fontFamily: AppFont.fontBold),
                    ),
                  ],
                ),
              ),
            );
          }
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
              postData.creatorId != controller.loggedInUserId
                  ? Get.to(() => ProfileScreen(postData.creatorId!))
                  : null;
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
            return MedicineShimmerWidget();
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

            return postDataList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => PostItemWidget(
                              context,
                              controller,
                              postDataList.elementAt(index),
                              index),
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.transparent),
                          itemCount: itemCount(postDataList)),
                      getBottomWidget(postDataList, context)
                    ],
                  )
                : Container(
                    height: 20.h,
                    margin: EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border:
                            Border.all(width: 1, color: AppColors.splashdetail),
                        borderRadius: BorderRadius.circular(5)),
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
                            ConstString.nopost,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontFamily: AppFont.fontBold),
                          ),
                        ],
                      ),
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

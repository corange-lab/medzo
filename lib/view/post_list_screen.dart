import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:medzo/view/image_preview_screen.dart';
import 'package:medzo/view/post_detail_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:shimmer/shimmer.dart';
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
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.postlist,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: Responsive.sp(4.8, context),
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.fetchAllPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // TODO: shimmer loading for 3 items in list
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView(
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
                            height: 15.h,
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
                            height: 15.h,
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
                            height: 15.h,
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
                            height: 15.h,
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
                            height: 15.h,
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

              return ListView.separated(
                  itemBuilder: (context, index) => PostItemWidget(context,
                      controller, postDataList.elementAt(index), index),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: postDataList.length);
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
          }),
    );
  }

  Widget PostItemWidget(BuildContext context, PostController controller,
      PostData postData, int index) {
    return GetBuilder<PostController>(
        id: postData.id ?? 'post${postData.id}',
        builder: (ctrl) {
          return GestureDetector(
            onTap: () async {
              controller.currentPostData = postData;
              await Get.to(() => PostDetailScreen())?.whenComplete(() {
                controller.currentPostData = null;
              });
            },
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(bottom: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PostHeaderWidget(context, postData,
                      controller.findUser(postData.creatorId!)),
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
                          fontSize: Responsive.sp(3.8, context),
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
                              horizontal: 5, vertical: 8),
                          child: Container(
                            height: 18.h,
                            alignment: Alignment.center,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // TODO: on Image click open a IMAGE IN NEW SCREEN
                                return GestureDetector(
                                  onTap: () {
                                    if (postData.postImages
                                            ?.elementAt(index)
                                            .url !=
                                        null) {
                                      Get.to(() => ImagePreviewScreen.withUrl(
                                          postData.postImages
                                                  ?.elementAt(index)
                                                  .url ??
                                              ''));
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CupertinoActivityIndicator(
                                              color: AppColors.primaryColor,
                                              animating: true,
                                              radius: 14,
                                            ),
                                          ),
                                          fit: BoxFit.contain,
                                        )),
                                    decoration: BoxDecoration(
                                        color: AppColors.dark.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                );
                              },
                              itemCount: (postData.postImages ?? []).length,
                            ),
                          ))
                      : SizedBox(),
                  Container(
                    height: 0.18.h,
                    width: SizerUtil.width,
                    color: AppColors.grey.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await controller.addLike(postData);
                          },
                          icon: controller.isLiked(postData)
                              ? Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.primaryColor,
                                )
                              : SvgPicture.asset(
                                  SvgIcon.likePost,
                                  height: 2.5.h,
                                ),
                          splashColor: Colors.transparent,
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
                          width: 2.w,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            SvgIcon.commentPost,
                            height: 2.8.h,
                          ),
                          splashColor: Colors.transparent,
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
      subtitle: Align(
        alignment: Alignment.topLeft,
        child: TextWidget(
          timeAgo(postData.createdTime ?? DateTime.now()),
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.grey.withOpacity(0.8),
              fontSize: Responsive.sp(3.4, context)),
        ),
      ),
    );
  }
}

// this screen is used to show post detail same as shown in the post List
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/chat/view/conversation_page/conversations_page.dart';
import 'package:medzo/controller/post_controller.dart';
import 'package:medzo/model/comment_data.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/image_preview_screen.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:sizer/sizer.dart';

class PostDetailScreen extends GetWidget<PostController> {
  PostDetailScreen({super.key});

  /// this screen is used to show post detail same as shown in the post List, UI will have similar to post single element and other details should be added like user can comment and like the post

  @override
  Widget build(BuildContext context) {
    /// UI is similar to post single element and other details should be added like user can comment and like the post
    return Scaffold(
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
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.postdetail,
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
      // FIXME: rendering issue
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            PostItemWidget(context, controller, controller.currentPostData!),
            Container(
              height: 0.18.h,
              width: SizerUtil.width,
              color: AppColors.grey.withOpacity(0.1),
            ),
            GetBuilder<PostController>(
                id: controller.currentPostData!.id ??
                    'post${controller.currentPostData!.id}',
                builder: (ctrl) {
                  print(
                      'updates-- ${controller.currentPostData!.postComments?.length.toString()}');
                  return CommentListWidget(
                      context: context,
                      controller: controller,
                      postData: controller.currentPostData!);
                }),
            SizedBox(height: 80)
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
                top: BorderSide(
                    color: AppColors.grey.withOpacity(0.1), width: 0.5))),
        child: Wrap(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: controller.replyActionEnabled()
                    ? ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        dense: true,
                        horizontalTitleGap: 10,
                        leading: OtherProfilePicWidget(
                            profilePictureUrl:
                                controller.replyingCommentUser?.profilePicture),
                        title: Align(
                          alignment: Alignment.topLeft,
                          child: TextWidget(
                            controller.replyingCommentUser?.name ?? '-',
                            textOverflow: TextOverflow.ellipsis,
                            maxLine: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontFamily: AppFont.fontFamilysemi,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3,
                                    fontSize: Responsive.sp(4.2, context)),
                          ),
                        ),
                        subtitle: TextWidget(
                          controller.replyingCommentData?.content ?? '-',
                          textAlign: TextAlign.start,
                          maxLine: 1,
                          textOverflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColors.grey.withOpacity(0.8),
                                  fontSize: Responsive.sp(3.4, context)),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: AppColors.grey.withOpacity(0.8),
                          ),
                          onPressed: () {
                            removeReplyAction(controller, context);
                          },
                        ))
                    : SizedBox()),
            InputCommentWidget(context, controller),
          ],
        ),
      ),
    );
  }

  Widget PostItemWidget(
      BuildContext context, PostController controller, PostData postData) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Container(
                    height: 20.h,
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
          SizedBox(height: 0.5.h),
          GetBuilder<PostController>(
              id: postData.id ?? 'post${postData.id}',
              builder: (ctrl) {
                return Padding(
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                        onTap: () async {},
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.txtlike,
                            letterSpacing: 0.3,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFont.fontFamily),
                      ),
                    ],
                  ),
                );
              }),
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

  Widget InputCommentWidget(BuildContext context, PostController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller.commentController,
              focusNode: controller.commentFocusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.grey.withOpacity(0.1),
                hintText: 'Write a comment...',
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.grey.withOpacity(0.8),
                    fontSize: Responsive.sp(3.4, context)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 17,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
            onTap: () async {
              // validate before comment add, if comment is empty then return
              if (controller.commentController.text.trim().isEmpty) {
                return;
              }

              PostData? mPostData;
              if (controller.replyActionEnabled()) {
                mPostData = await controller
                    .addCommentOfComment(controller.replyingCommentData!);
              } else {
                mPostData = await controller.addComment();
              }
              if (mPostData != null) {
                controller.currentPostData = mPostData;
                controller.update([
                  controller.currentPostData!.id ??
                      'post${controller.currentPostData!.id}'
                ]);
                removeReplyAction(controller, context);
              }
            },
            child: Container(
              height: 5.5.h,
              width: 5.5.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30)),
              child: Icon(
                Icons.send_rounded,
                color: AppColors.white,
                size: 3.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void removeReplyAction(PostController controller, BuildContext context) {
    controller.replyingCommentData = null;
    controller.replyingCommentUser = null;
    controller.update([
      controller.currentPostData!.id ?? 'post${controller.currentPostData!.id}'
    ]);
    closeKeyboard(context);
  }

  Widget CommentListWidget(
      {required BuildContext context,
      required PostController controller,
      required PostData postData}) {
    // implement UI for the all comments from the postData and bind into the ListView
    return ListView.separated(
        // physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // design a best UI for the comment
          CommentData? commentData = postData.postComments?.elementAt(index);
          UserModel? commentedUser =
              controller.findUser(commentData?.commentUserId ?? '');

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: EdgeInsets.all(10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                ),
                child: ListTile(
                  tileColor: AppColors.listtile,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  dense: true,
                  horizontalTitleGap: 10,
                  leading: OtherProfilePicWidget(
                      profilePictureUrl: commentedUser.profilePicture),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 0.8.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: TextWidget(
                            commentedUser.name ?? '-',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    fontFamily: AppFont.fontFamilysemi,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.3,
                                    fontSize: Responsive.sp(4.2, context)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: TextWidget(
                          timeAgo(commentData?.createdTime ?? DateTime.now()),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: Responsive.sp(3.4, context),
                                  color: AppColors.dark),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: TextWidget(
                          commentData?.content ?? '-',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColors.grey,
                                  fontSize: Responsive.sp(3.4, context),
                                  fontFamily: AppFont.fontFamily),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                    ],
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ParentCommentDeleteButton(postData, commentData!),
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await controller.addLikeOnComment(
                              postData, commentData.id!);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: controller.hasLikedThisComment(commentData)
                              ? Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.primaryColor,
                                  size: 2.h,
                                )
                              : SvgPicture.asset(
                                  SvgIcon.likePost,
                                  height: 1.8.h,
                                ),
                        ),
                      ),
                      SizedBox(width: 0.8.w),
                      Text(
                        commentData.likedUsers?.length.toString() ?? "0",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.txtlike,
                            letterSpacing: 0.3,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppFont.fontFamily),
                      ),
                    ],
                  ),
                  SizedBox(width: 2.w),
                  Row(
                    children: [
                      SvgPicture.asset(
                        SvgIcon.commentPost,
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            controller.replyingCommentData = commentData;
                            controller.replyingCommentUser = commentedUser;
                            controller
                                .update([postData.id ?? 'post${postData.id}']);
                            FocusScope.of(context)
                                .requestFocus(controller.commentFocusNode);
                          },
                          child: Text(
                            "Reply",
                            style: TextStyle(
                              color: AppColors.blacktxt,
                              fontFamily: AppFont.fontFamilysemi,
                              decoration: TextDecoration.underline,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 50),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            CommentData? commentOfCommentData =
                                commentData.commentComments?.elementAt(index);
                            UserModel? commentedUser = controller.findUser(
                                commentOfCommentData?.commentUserId ?? '');
                            return CommentOfCommentWidget(commentData,
                                commentOfCommentData!, commentedUser, context);
                          },
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.transparent,
                              ),
                          itemCount: commentData.commentComments?.length ?? 0),
                    ),
                  ),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
              height: 3.h,
            ),
        itemCount: postData.postComments?.length ?? 0);
  }

  Widget CommentOfCommentWidget(CommentData parentCommentData,
      CommentData commentData, UserModel userModel, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Adjust the radius as needed
          ),
          child: ListTile(
            tileColor: AppColors.listtile,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            dense: true,
            horizontalTitleGap: 0,
            leading: SizedBox(
              height: 30,
              width: 30,
              child: OtherProfilePicWidget(
                  profilePictureUrl: userModel.profilePicture),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 1.5.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    userModel.name ?? '-',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: Responsive.sp(4, context)),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: TextWidget(
                    timeAgo(commentData.createdTime ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: Responsive.sp(3.4, context),
                        color: AppColors.dark),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: TextWidget(
                    commentData.content ?? '-',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.grey.withOpacity(0.8),
                        fontFamily: AppFont.fontFamily,
                        letterSpacing: 0,
                        fontSize: Responsive.sp(3.4, context)),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ChildCommentDeleteButton(parentCommentData, commentData),
            ),
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    // FIXME: implement
                    await controller.addLikeOnCommentOfComment(
                        parentCommentData, commentData, commentData.id!);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: controller.hasLikedThisCommentOfComment(commentData)
                        ? Icon(
                            Icons.favorite_rounded,
                            color: AppColors.primaryColor,
                            size: 2.h,
                          )
                        : SvgPicture.asset(
                            SvgIcon.likePost,
                            height: 1.8.h,
                          ),
                  ),
                ),
                SizedBox(width: 0.5.w),
                Container(
                  child: Text(
                    commentData.likedUsers?.length.toString() ?? "0",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.txtlike,
                        letterSpacing: 0.3,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFont.fontFamily),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 2.w,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  SvgIcon.commentPost,
                  height: 2.h,
                ),
                SizedBox(
                  width: 1.w,
                ),
                GestureDetector(
                  onTap: () {
                    controller.replyingCommentData = commentData;
                    controller.replyingCommentUser = userModel;
                    controller.update([
                      controller.currentPostData!.id ??
                          'post${controller.currentPostData!.id}'
                    ]);
                    FocusScope.of(context)
                        .requestFocus(controller.commentFocusNode);
                  },
                  child: Text(
                    "Reply",
                    style: TextStyle(
                      color: AppColors.blacktxt,
                      fontFamily: AppFont.fontFamilysemi,
                      decoration: TextDecoration.underline,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget ParentCommentDeleteButton(PostData postData, CommentData commentData) {
    if (commentData.commentUserId != controller.loggedInUserId) {
      return SizedBox();
    }
    return GestureDetector(
        onTap: () async {
          // TODO: confirmation dialog
          await controller.deleteComment(postData, commentData);
        },
        child: Icon(Icons.delete_rounded, color: AppColors.dark, size: 2.5.h));
  }

  Widget ChildCommentDeleteButton(
      CommentData parentCommentData, CommentData commentData) {
    if (commentData.commentUserId != controller.loggedInUserId) {
      return SizedBox();
    }
    return GestureDetector(
        onTap: () async {
          // TODO: confirmation dialog
          await controller.deleteCommentOfComment(
              parentCommentData, commentData, commentData.id!);
        },
        child: Icon(Icons.delete_rounded, color: AppColors.dark, size: 2.5.h));
  }

  void closeKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    controller.commentFocusNode.unfocus();
  }
}

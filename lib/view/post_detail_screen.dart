// this screen is used to show post detail same as shown in the post List
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:medzo/view/image_preview_screen.dart';
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
      appBar: AppBar(
        title: TextWidget(
          'Post Detail',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.dark,
              fontSize: Responsive.sp(4.5, context),
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.dark,
          ),
        ),
      ),
      // FIXME: rendering issue
      body: SingleChildScrollView(
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
          PostHeaderWidget(
              context, postData, controller.findUser(postData.creatorId!)),
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
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Container(
                    height: 18.h,
                    alignment: Alignment.center,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // TODO: on Image click open a IMAGE IN NEW SCREEN
                        return GestureDetector(
                          onTap: () {
                            if (postData.postImages?.elementAt(index).url !=
                                null) {
                              Get.to(() => ImagePreviewScreen.withUrl(
                                  postData.postImages?.elementAt(index).url ??
                                      ''));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
          GetBuilder<PostController>(
              id: postData.id ?? 'post${postData.id}',
              builder: (ctrl) {
                return Padding(
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
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              // height: 6.5.h,
              decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                controller: controller.commentController,
                focusNode: controller.commentFocusNode,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write a comment...',
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.grey.withOpacity(0.8),
                        fontSize: Responsive.sp(3.4, context))),
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
              height: 6.5.h,
              width: 15.w,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(
                Icons.send_rounded,
                color: AppColors.white,
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
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                dense: true,
                horizontalTitleGap: 10,
                leading: OtherProfilePicWidget(
                    profilePictureUrl: commentedUser.profilePicture),
                title: Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    commentedUser.name ?? '-',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.3,
                        fontSize: Responsive.sp(4.2, context)),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: TextWidget(
                        commentData?.content ?? '-',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.grey.withOpacity(0.8),
                            fontSize: Responsive.sp(3.4, context)),
                      ),
                    ),
                    ParentCommentDeleteButton(postData, commentData!),
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
                                    size: 15,
                                  )
                                : SvgPicture.asset(
                                    SvgIcon.likePost,
                                    height: 15,
                                  ),
                          ),
                        ),
                        Text(
                          commentData.likedUsers?.length.toString() ?? "0",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: AppColors.txtlike,
                                  letterSpacing: 0.3,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppFont.fontFamily),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 60),
                child: GestureDetector(
                  onTap: () {
                    controller.replyingCommentData = commentData;
                    controller.replyingCommentUser = commentedUser;
                    controller.update([postData.id ?? 'post${postData.id}']);
                    FocusScope.of(context)
                        .requestFocus(controller.commentFocusNode);
                  },
                  child: Text(
                    "Reply",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: AppFont.fontFamily,
                      decoration: TextDecoration.underline,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
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
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: commentData.commentComments?.length ?? 0),
                    ),
                  ),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: postData.postComments?.length ?? 0);
  }

  Widget CommentOfCommentWidget(CommentData parentCommentData,
      CommentData commentData, UserModel userModel, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          dense: true,
          horizontalTitleGap: 0,
          leading: SizedBox(
            height: 30,
            width: 30,
            child: OtherProfilePicWidget(
                profilePictureUrl: userModel.profilePicture),
          ),
          title: Align(
            alignment: Alignment.topLeft,
            child: TextWidget(
              userModel.name ?? '-',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: Responsive.sp(4.2, context)),
            ),
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: TextWidget(
                  commentData.content ?? '-',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.grey.withOpacity(0.8),
                      fontSize: Responsive.sp(3.4, context)),
                ),
              ),
              ChildCommentDeleteButton(parentCommentData, commentData),
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
                      child:
                          controller.hasLikedThisCommentOfComment(commentData)
                              ? Icon(
                                  Icons.favorite_rounded,
                                  color: AppColors.primaryColor,
                                  size: 15,
                                )
                              : SvgPicture.asset(
                                  SvgIcon.likePost,
                                  height: 15,
                                ),
                    ),
                  ),
                  Text(
                    commentData.likedUsers?.length.toString() ?? "0",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: AppColors.txtlike,
                        letterSpacing: 0.3,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFont.fontFamily),
                  ),
                ],
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.replyingCommentData = commentData;
            controller.replyingCommentUser = userModel;
            controller.update([
              controller.currentPostData!.id ??
                  'post${controller.currentPostData!.id}'
            ]);
            FocusScope.of(context).requestFocus(controller.commentFocusNode);
          },
          child: Text(
            "Reply",
            style: TextStyle(
              color: Colors.grey,
              fontFamily: AppFont.fontFamily,
              decoration: TextDecoration.underline,
              fontSize: 10.sp,
            ),
          ),
        )
      ],
    );
  }

  Widget ParentCommentDeleteButton(PostData postData, CommentData commentData) {
    if (commentData.commentUserId != controller.loggedInUserId) {
      return SizedBox();
    }
    return IconButton(
        onPressed: () async {
          // TODO: confirmation dialog
          await controller.deleteComment(postData, commentData);
        },
        icon: Icon(Icons.delete_rounded, color: AppColors.dark, size: 15));
  }

  Widget ChildCommentDeleteButton(
      CommentData parentCommentData, CommentData commentData) {
    if (commentData.commentUserId != controller.loggedInUserId) {
      return SizedBox();
    }
    return IconButton(
        onPressed: () async {
          // TODO: confirmation dialog
          await controller.deleteCommentOfComment(
              parentCommentData, commentData, commentData.id!);
        },
        icon: Icon(Icons.delete_rounded, color: AppColors.dark, size: 15));
  }

  void closeKeyboard(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    controller.commentFocusNode.unfocus();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/review_data_model.dart';
import 'package:medzo/model/review_reply_data.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/date_time_extensions.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewReplyScreen extends StatelessWidget {
  final UserModel? user;
  final ReviewDataModel? review;
  final MedicineController controller = Get.put(MedicineController());

  ReviewReplyScreen(this.user, this.review);

  AllUserController allUserController = Get.put(AllUserController());

  @override
  Widget build(BuildContext context) {
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
              height: 15,
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.reviewReply,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17.5,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _deleteReviewDialog(context);
              },
              icon: Icon(
                Icons.delete_outlined,
                color: AppColors.notificationOff,
                size: 3.5.h,
              )),
        ],
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GetBuilder<MedicineController>(builder: (ctrl) {
              return reviewHeaderWidget(context);
            }),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 0.18.h,
              width: SizerUtil.width,
              color: AppColors.grey.withOpacity(0.1),
            ),
            GetBuilder<MedicineController>(
              id: controller.currentReviewData!.id ??
                  'reply${controller.currentReviewData!.id}',
              builder: (ctrl) {
                print(
                    "replies-- ${controller.currentReviewData!.reviewReplies?.length.toString()}");

                return ReplyListWidget(
                    context, controller, controller.currentReviewData!);
              },
            ),
            SizedBox(
              height: 9.h,
            )
          ],
        ),
      ),
      bottomSheet: InputReplyWidget(context),
    );
  }

  Widget reviewHeaderWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: AppColors.splashdetail),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          children: [
            ListTile(
              leading: OtherProfilePicWidget(
                profilePictureUrl: user!.profilePicture,
                size: Size(45, 45),
              ),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  TextWidget(
                    "${user!.name}",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontFamily: AppFont.fontBold, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    "${user!.profession ?? "-"}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.grey,
                        fontFamily: AppFont.fontMedium,
                        fontWeight: FontWeight.w500,
                        fontSize: 11),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SmoothStarRating(
                    rating: review!.rating!,
                    allowHalfRating: true,
                    defaultIconData: Icons.star_outline_rounded,
                    filledIconData: Icons.star_rounded,
                    halfFilledIconData: Icons.star_half_rounded,
                    starCount: 5,
                    size: 20,
                    color: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextWidget(
                  "${review!.review}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      height: 1.7,
                      fontSize: 14,
                      fontFamily: AppFont.fontMedium,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.dark),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.addUpvote(review!, isForUpvote: true);
                    },
                    icon: Icon(
                      Icons.plus_one,
                      color: controller.isVoted(review!, forUpvote: true)
                          ? Colors.red
                          : Colors.black,
                    )),
                IconButton(
                    onPressed: () {
                      controller.addUpvote(review!, isForUpvote: false);
                    },
                    icon: Icon(
                      Icons.exposure_minus_1,
                      color: controller.isVoted(review!, forUpvote: false)
                          ? Colors.red
                          : Colors.black,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget InputReplyWidget(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 15, left: 10, right: 10, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: controller.replyController,
                focusNode: controller.replyFocusNode,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: AppColors.grey.withOpacity(0.1),
                  hintText: 'Write a Reply...',
                  hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.grey.withOpacity(0.8), fontSize: 14),
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
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 2.w,
            ),
            GestureDetector(
              onTap: () async {
                ReviewDataModel? reviewData;

                reviewData = await controller.addReply();

                if (reviewData != null) {
                  controller.currentReviewData = reviewData;

                  controller.update([
                    controller.currentReviewData!.id ??
                        'reply${controller.currentReviewData!.id}'
                  ]);
                }
              },
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30)),
                child: Icon(
                  Icons.send_rounded,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ReplyListWidget(BuildContext context, MedicineController controller,
      ReviewDataModel reviewData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GetBuilder<MedicineController>(builder: (ctrl) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: 3);
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviewData.reviewReplies?.length ?? 0,
          itemBuilder: (context, index) {
            ReviewReplyModel? replyData =
                reviewData.reviewReplies?.elementAt(index);

            UserModel? replyUser = controller.findUser(replyData?.userId ?? '');

            return !allUserController.blockedUserList.contains(replyUser.id)
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.listtile),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 10, bottom: 10, right: 10),
                              child: OtherProfilePicWidget(
                                  profilePictureUrl: replyUser.profilePicture,
                                  size: Size(40, 40)),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          replyUser.name ?? '-',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  fontFamily:
                                                      AppFont.fontFamilysemi,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.3,
                                                  fontSize: 14),
                                        ),
                                        SizedBox(height: 10),
                                        TextWidget(
                                          (replyData?.repliedTime ??
                                                  DateTime.now())
                                              .timeAgo(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  fontSize: 11,
                                                  color: AppColors.dark),
                                        ),
                                      ],
                                    ),
                                  ),
                                  replyData!.userId == controller.currentUser
                                      ? IconButton(
                                          onPressed: () {
                                            _deleteReviewDialog(context,
                                                isForReply: true,
                                                replyData: replyData);
                                          },
                                          icon: Icon(
                                            Icons.delete_outlined,
                                            color: AppColors.notificationOff,
                                            // size: 3.5.h,
                                          ))
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: TextWidget(
                              "${replyData.reply}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      height: 1.7,
                                      fontSize: 14,
                                      fontFamily: AppFont.fontMedium,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.dark),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.addReplyUpvote(replyData,
                                      isForUpvote: true);
                                },
                                icon: Icon(
                                  Icons.plus_one,
                                  color: controller.isReplyVoted(replyData,
                                          forUpvote: true)
                                      ? Colors.red
                                      : Colors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  controller.addReplyUpvote(replyData,
                                      isForUpvote: false);
                                },
                                icon: Icon(
                                  Icons.exposure_minus_1,
                                  color: controller.isReplyVoted(replyData,
                                          forUpvote: false)
                                      ? Colors.red
                                      : Colors.black,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox();
          },
        );
      }),
    );
  }

  void _deleteReviewDialog(BuildContext context,
      {bool isForReply = false, ReviewReplyModel? replyData}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextWidget(
            ConstString.deleteReview,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 19,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
          content: TextWidget(
            ConstString.deleteReviewMessage,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                letterSpacing: 0,
                height: 1.3,
                color: AppColors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: TextWidget(
                ConstString.cancel,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontFamily: AppFont.fontFamilysemi,
                    letterSpacing: 0,
                    color: AppColors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (isForReply) {
                  if (replyData!.reply != null) {
                    await controller.deleteReviewReply(review!, replyData);
                  }
                } else {
                  await controller.deleteReview(review!);
                }
                Get.back();
                Get.back(result: 'Delete');
              },
              child: TextWidget(
                ConstString.delete,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontFamily: AppFont.fontFamilysemi,
                    letterSpacing: 0,
                    color: AppColors.notificationOff),
              ),
            ),
          ],
        );
      },
    );
  }
}

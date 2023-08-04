import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/new_post_controller.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:medzo/widgets/pick_image.dart';
import 'package:sizer/sizer.dart';

class AddPostScreen extends GetView<NewPostController> {
  @override
  Widget build(BuildContext context) {
    pickImageController pickController = Get.put(pickImageController());
    NewPostController controller = Get.isRegistered<NewPostController>()
        ? Get.find<NewPostController>()
        : Get.put(NewPostController());

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
            ConstString.newpost,
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
      body: addpostWidget(context, pickController, controller),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: ElevatedButton(
          onPressed: () async {
            progressDialogue(context, title: "Post Uploading");
            List<PostImageData> imagelist = [];
            // List<PostImageData> postData = [];

            // for (var i = 0; i < controller.selectedMultiImages.length; i++) {
            PostImageData image = PostImageData(
              path: controller.postImageFile.value,
              uploaded: false,
            );
            // imagelist.add(image);
            // }

            final postId = controller.postRef.doc().id;

            PostImageData mImage = PostImageData();

            // for (int i = 0; i < imagelist.length; i++) {
            //   mImage = imagelist.elementAt(i);
            String? imageUrl = await controller.uploadImage(image);

            mImage = mImage.copyWith(
                id: postId,
                uploaded: true,
                url: imageUrl,
                path: controller.postImageFile.value);
            // imagelist[i] = mImage;
            // }

            // postData = await controller.fetchImages(imagelist);

            PostData newPostData = PostData.create(
              postImages: mImage,
              description: controller.description.text,
              creatorId: controller.loggedInUserId,
              id: postId,
              createdTime: DateTime.now(),
            );

            controller.postRef
                .doc()
                .set(newPostData.toMap())
                .then((value) async {
              newPostData = PostData.fromMap(newPostData.toFirebaseMap());

              newPostData = newPostData.copyWith(id: postId);

              // if (imagelist.every((element) => element.uploaded == true)) {
              showDialog(
                context: context,
                builder: (context) {
                  return successDialogue(
                    titleText: "Successful Uploaded",
                    subtitle: "Your post has been uploaded successfully.",
                    iconDialogue: SvgIcon.check_circle,
                    btntext: "View",
                    onPressed: () {
                      Get.back();
                      Get.back();
                      Get.back();
                    },
                  );
                },
              );
              // } else {
              //   showDialog(
              //     context: context,
              //     builder: (context) {
              //       return FailureDialog(
              //         titleText: "Failed to Upload",
              //         subtitle: "Your post has been failed to upload.",
              //         iconDialogue: SvgIcon.info,
              //         btntext: "Close",
              //         onPressed: () {
              //           Get.back();
              //         },
              //       );
              //     },
              //   );
              // }
            });
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(Responsive.width(50, context), 60),
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: TextWidget(
            ConstString.uploadpost,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: Responsive.sp(4, context),
                color: AppColors.buttontext,
                fontFamily: AppFont.fontMedium),
          ),
        ),
      ),
    );
  }

  // void onChooseFile(File value) {
  //   controller.selectedMultiImages.add(value);
  //   controller.update();
  // }

  Widget addpostWidget(BuildContext context, pickImageController pickController,
      NewPostController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              await pickController.pickPostImage();
              controller.postImageFile = pickController.croppedPostFile!.path.obs;
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: SizerUtil.width,
              height: Responsive.height(20, context),
              decoration: BoxDecoration(
                  color: AppColors.tilecolor,
                  borderRadius: BorderRadius.circular(7),
                  border:
                      Border.all(color: AppColors.primaryColor, width: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.upload_image,
                    height: Responsive.height(4, context),
                  ),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  TextWidget(
                    ConstString.uploadimage,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.darkyellow.withOpacity(0.9),
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.sp(4, context)),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => controller.postImageFile.value.isNotEmpty
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        height: 12.h,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                                File(controller.postImageFile.value)))),
                  )
                : SizedBox(),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                ConstString.description,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: Responsive.sp(3.8, context),
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFont.fontMedium),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: false,
              maxLength: 500,
              controller: controller.description,
              cursorColor: AppColors.grey,
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: AppColors.searchbar.withOpacity(0.5),
                hintText: "Add Description",
                hintStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: Responsive.sp(4, context)),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.whitehome, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.whitehome, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.whitehome, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.whitehome, width: 0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

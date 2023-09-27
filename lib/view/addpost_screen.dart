import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/new_post_controller.dart';
import 'package:medzo/model/post_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:medzo/widgets/pick_image.dart';
import 'package:sizer/sizer.dart';

class AddPostScreen extends GetView<NewPostController> {
  PostData? postData;

  AddPostScreen({this.postData});

  @override
  Widget build(BuildContext context) {
    pickImageController pickController = Get.put(pickImageController());
    NewPostController controller = Get.isRegistered<NewPostController>()
        ? Get.find<NewPostController>()
        : Get.put(NewPostController());

    // log("${postData!.postImages![0]}");

    if (postData != null && postData!.id != null && postData!.id!.isNotEmpty) {
      controller.description.text = postData?.description ?? "";
    } else {
      controller.description.text = "";
    }

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
            ConstString.newpost,
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
      body: addPostWidget(context, pickController, controller),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: ElevatedButton(
          onPressed: () async {
            if (controller.description.text.trim().isEmpty) {
              toast(message: "Please add description");
              return;
            }

            progressDialogue(context, title: "Post Uploading");

            List<PostImageData> imageList = [];

            final postId = controller.postRef.doc().id;

            PostImageData mImage = PostImageData();

            if (controller.selectedMultiImages.length > 0) {
              for (var i = 0; i < controller.selectedMultiImages.length; i++) {
                PostImageData image = PostImageData(
                  path: controller.selectedMultiImages[i].path,
                  uploaded: false,
                );
                imageList.add(image);
              }

              for (int i = 0; i < imageList.length; i++) {
                mImage = imageList.elementAt(i);
                String? imageUrl = await controller.uploadImage(mImage);
                if (imageUrl != null) {
                  String imageId = controller.postRef.doc().id;
                  mImage = mImage.copyWith(
                      id: imageId,
                      postId: postId,
                      uploaded: true,
                      url: imageUrl,
                      path: imageList[i].path);
                }
                imageList[i] = mImage;
              }
            }

            PostData newPostData = PostData.create(
              postImages: imageList,
              description: controller.description.text.trim(),
              creatorId: controller.loggedInUserId,
              id: postId,
              createdTime: DateTime.now(),
            );

            if (postData != null &&
                postData!.id != null &&
                postData!.id!.isNotEmpty) {
              await controller.postRef.doc(postData!.id).update({
                'description': controller.description.text.trim(),
              }).then((value) {
                if (imageList.every((element) => element.uploaded == true)) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return successDialogue(
                        titleText: "Successful Updated",
                        subtitle: "Your post has been Updated successfully.",
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
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FailureDialog(
                        titleText: "Failed to Update",
                        subtitle: "Your post has been failed to update.",
                        iconDialogue: SvgIcon.info,
                        btntext: "Close",
                        onPressed: () {
                          Get.back();
                        },
                      );
                    },
                  );
                }
              }).catchError((onError) {
                log("Failed to update description: $onError");
              });
            } else {
              await controller.postRef
                  .doc(postId)
                  .set(newPostData.toMap())
                  .then((value) async {
                newPostData = PostData.fromMap(newPostData.toFirebaseMap());

                newPostData = newPostData.copyWith(id: postId);
                controller.selectedMultiImages.clear();

                if (imageList.every((element) => element.uploaded == true)) {
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
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FailureDialog(
                        titleText: "Failed to Upload",
                        subtitle: "Your post has been failed to upload.",
                        iconDialogue: SvgIcon.info,
                        btntext: "Close",
                        onPressed: () {
                          Get.back();
                        },
                      );
                    },
                  );
                }
              });
            }
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(160, 60),
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: TextWidget(
            postData != null ? ConstString.updatepost : ConstString.uploadpost,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 15,
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

  Widget addPostWidget(BuildContext context, pickImageController pickController,
      NewPostController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              // TODO: check below each condition
              await pickController.pickPostImage();
              controller.postImageFile =
                  await pickController.croppedPostFile!.path.obs;
              controller.selectedMultiImages
                  .add(File(controller.postImageFile.value));
              print(controller.selectedMultiImages);
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              width: SizerUtil.width,
              height: 160,
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
                    height: 32,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextWidget(
                    ConstString.uploadimage,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.darkyellow.withOpacity(0.9),
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          postData != null && postData!.id != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: postData!.postImages!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: postData!.postImages![index].url!,
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
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Obx(
                  () => controller.selectedMultiImages.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Container(
                            height: 110,
                            width: SizerUtil.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.selectedMultiImages.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(controller
                                            .selectedMultiImages[index])));
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                ConstString.description,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 14,
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
              minLines: 1,
              maxLines: 5,
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
                    .copyWith(fontSize: 14),
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

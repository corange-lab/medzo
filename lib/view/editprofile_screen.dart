import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/view/login_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:medzo/widgets/pick_image.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;

  EditProfileScreen(this.userModel);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  pickImageController pickController = Get.put(pickImageController());
  ProfileController controller = Get.find<ProfileController>();
  late UserModel userModel;

  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    userModel = widget.userModel.copyWith(
        name: widget.userModel.name,
        profession: widget.userModel.profession,
        email: widget.userModel.email,
        profilePicture: widget.userModel.profilePicture,
        id: widget.userModel.id);
    super.initState();
    controller.nameController.text = userModel.name ?? '';
    controller.professionController.text = userModel.profession ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
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
            ConstString.editprofile,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17.5,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
                onPressed: () async {
                  return await deleteDialogue(context, () async {
                    Get.back();
                    bool hasInternet = await Utils.hasInternetConnection();
                    if (!hasInternet) {
                      showInSnackBar(ConstString.noConnection);
                      return;
                    }
                    // show loading dialog while deleting user
                    progressDialogue(context, title: "Deleting Account");
                    await deleteUserFirestoreData();
                    Get.back();
                    Get.offAll(() => LoginScreen());
                    return;
                  });
                },
                icon: Icon(
                  CupertinoIcons.delete_solid,
                  color: Colors.red,
                  size: 20,
                )),
          )
        ],
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: editProfileWidget(context, controller, pickController),
    );
  }

  Widget editProfileWidget(BuildContext context, ProfileController controller,
      pickImageController pickController) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: pickController.selectedImage.isEmpty
                        ? CircleAvatar(
                            maxRadius: 55,
                            backgroundColor: AppColors.blue.withOpacity(0.1),
                            backgroundImage:
                                AssetImage(AppImages.profile_picture),
                          )
                        : Obx(() => ClipOval(
                              child: Container(
                                height: 110,
                                width: 110,
                                child: Image.file(
                                  File(pickController.selectedImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ))),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextWidget(
                    ConstString.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey.withOpacity(0.9),
                        fontSize: 15,
                        letterSpacing: 0,
                        fontFamily: AppFont.fontMedium),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 25, left: 15),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.nameController,
                  cursorColor: AppColors.grey,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Enter your name",
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
                      horizontal: 18,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextWidget(
                    ConstString.profession,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey.withOpacity(0.9),
                        fontSize: 15,
                        letterSpacing: 0,
                        fontFamily: AppFont.fontMedium),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 25, left: 15),
                child: TextFormField(
                  autofocus: false,
                  controller: controller.professionController,
                  cursorColor: AppColors.grey,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Enter your profession",
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
                      horizontal: 18,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  progressDialogue(context, title: "Profile updating");
                  String name = controller.nameController.text.trim();
                  String profession =
                      controller.professionController.text.trim();
                  String userid = FirebaseAuth.instance.currentUser!.uid;

                  if (name.isNotEmpty && profession.isNotEmpty) {
                    try {
                      final ref =
                          FirebaseStorage.instance.ref('profile_pics/$userid');
                      final picFile = File(pickController.selectedImage);
                      if (await picFile.exists()) {
                        UploadTask uploadTask = ref.putFile(picFile);

                        await Future.value(uploadTask).then((value) async {
                          var newUrl = await ref.getDownloadURL();
                          await UserRepository.getInstance()
                              .updateUser(userModel.copyWith(
                                  name: name,
                                  profession: profession,
                                  email:
                                      FirebaseAuth.instance.currentUser!.email,
                                  profilePicture: newUrl.toString(),
                                  id: FirebaseAuth.instance.currentUser!.uid))
                              .then((value) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return successDialogue(
                                  titleText: "Successful Changed",
                                  subtitle:
                                      "Your profile has been changed successfully.",
                                  iconDialogue: SvgIcon.check_circle,
                                  btntext: "Done",
                                  onPressed: () {
                                    Get.back();
                                    Get.back();
                                    Get.back();
                                  },
                                );
                              },
                            );
                          }).onError((error, stackTrace) {
                            showInSnackBar("$error", isSuccess: false);
                          });
                        }).onError((error, stackTrace) {
                          showInSnackBar("${error}", isSuccess: false);
                        });
                      } else {
                        UserModel? userModel =
                            await AuthApi.instance.getLoggedInUserData();
                        await UserRepository.getInstance().updateUser(UserModel(
                            name: name,
                            profession: profession,
                            email: FirebaseAuth.instance.currentUser!.email,
                            profilePicture: userModel?.profilePicture,
                            id: FirebaseAuth.instance.currentUser!.uid));
                        Get.back();
                        Get.back();
                      }
                    } catch (e) {
                      print("Exception Thrown : $e");
                    }
                  } else {
                    Get.back();
                    toast(message: "Please fill all the fields!");
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(180, 55),
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: TextWidget(
                  ConstString.save,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColors.buttontext, fontSize: 15),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 85,
          right: 120,
          child: GestureDetector(
            onTap: () async {
              await pickController.pickImage(context);
            },
            child: ClipOval(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    SvgIcon.pencil,
                    height: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future deleteDialogue(BuildContext context, Function() callback) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25),
          backgroundColor: AppColors.white,
          shape: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          alignment: Alignment.center,
          title: Column(
            children: [
              Icon(
                CupertinoIcons.delete,
                size: 40,
                color: Colors.red,
              ),
              SizedBox(height: 25),
              Text(
                ConstString.deleteAccount,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.darkPrimaryColor,
                      fontFamily: AppFont.fontFamilysemi,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextWidget(
                  "Are you sure you want to delete your account?\nAll information will be deleted. That can't be UNDONE",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      color: AppColors.grey.withOpacity(0.9),
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.fontFamily,
                      letterSpacing: 0),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        callback();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(20, 55),
                          backgroundColor: AppColors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0),
                      child: Text(
                        "Yes",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColors.buttontext,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFont.fontMedium,
                                fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(20, 55),
                          backgroundColor: AppColors.splashdetail,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0),
                      child: TextWidget(
                        "NO",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColors.dark,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFont.fontMedium,
                                fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteUserFirestoreData() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    /// Delete user reviews
    await deleteUserReviews(currentUserId);

    /// Delete user Posts
    await deleteUserPosts(currentUserId);

    // Delete user favorites
    await deleteUserFavouriteMedicines(currentUserId);

    // Delete user conversation participants
    await deleteUserConversations(currentUserId);

    await removeCommentUserIdFromPostComments(currentUserId);
    await removeUserIdFromLikedUsersInPostComments(currentUserId);
    await removeUserIdFromLikedUsersInCommentComments(currentUserId);

    // Delete user's followers and following
    await deleteUserFollowFollowings(currentUserId);

    await deleteUser(currentUserId);
  }

  Future<void> removeCommentUserIdFromPostComments(String userId) async {
    // Fetch posts where any postComment's "commentUserId" is the user's ID
    final QuerySnapshot querySnapshot = await instance()
        .collection('posts')
        .where('postComments', arrayContains: {
      'commentUserId': userId,
    }).get();

    // Update each post document to remove the user's ID from commentUserId
    querySnapshot.docs.forEach((doc) async {
      List<Map<String, dynamic>> postComments = List.from(doc['postComments']);

      postComments.removeWhere((comment) => comment['commentUserId'] == userId);

      await doc.reference.update({'postComments': postComments});
    });
  }

  Future<void> removeUserIdFromLikedUsersInPostComments(String userId) async {
    // Fetch posts where any postComment's "likedUsers" contains the user's ID
    final QuerySnapshot querySnapshot = await instance()
        .collection('posts')
        .where('postComments', arrayContains: {
      'likedUsers': userId,
    }).get();

    // Update each post document to remove the user's ID from "likedUsers" in postComments
    querySnapshot.docs.forEach((doc) async {
      List<Map<String, dynamic>> postComments = List.from(doc['postComments']);

      postComments.forEach((comment) {
        if (comment.containsKey('likedUsers')) {
          List<String> likedUsers = List.from(comment['likedUsers']);
          likedUsers.remove(userId); // Remove the user's ID from likedUsers
          comment['likedUsers'] = likedUsers;
        }
      });

      await doc.reference.update({'postComments': postComments});
    });
  }

  Future<void> removeUserIdFromLikedUsersInCommentComments(
      String userId) async {
    // Fetch posts where any postComment's "commentComments" have likedUsers containing user's ID
    final QuerySnapshot querySnapshot =
        await instance().collection('posts').get();

    // Update each post document to remove the user's ID from "likedUsers" in commentComments
    querySnapshot.docs.forEach((doc) async {
      List<Map<String, dynamic>> postComments = List.from(doc['postComments']);

      List<Map<String, dynamic>> updatedComments = [];

      postComments.forEach((comment) {
        if (comment.containsKey('commentComments')) {
          List<Map<String, dynamic>> commentComments =
              List.from(comment['commentComments']);

          List<Map<String, dynamic>> updatedSubComments = [];

          commentComments.forEach((subComment) {
            if (subComment.containsKey('likedUsers')) {
              List<String> likedUsers = List.from(subComment['likedUsers']);
              likedUsers.remove(userId); // Remove the user's ID from likedUsers
              subComment['likedUsers'] = likedUsers;
            }
            updatedSubComments.add(subComment);
          });

          comment['commentComments'] = updatedSubComments;
        }
        updatedComments.add(comment);
      });

      await doc.reference.update({'postComments': updatedComments});
    });
  }

  Future<void> deleteUserConversations(String currentUserId) async {
    final QuerySnapshot conversationQuerySnapshot = await instance()
        .collection('conversation')
        .where('participants.$currentUserId', isEqualTo: true)
        .get();

    // Delete each conversation document
    conversationQuerySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  Future<void> deleteUserFavouriteMedicines(String currentUserId) async {
    await instance().collection("favourites").doc(currentUserId).delete();
  }

  Future<void> deleteUserFollowFollowings(String currentUserId) async {
    QuerySnapshot<Map<String, dynamic>> followingUsersQuerySnapshot =
        await instance()
            .collection('followers')
            .doc(currentUserId)
            .collection('user_following')
            .get();

    followingUsersQuerySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });

    QuerySnapshot<Map<String, dynamic>> followersUsersQuerySnapshot =
        await instance()
            .collection('followers')
            .doc(currentUserId)
            .collection('user_followers')
            .get();
    followersUsersQuerySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  Future<void> deleteUser(String currentUserId) async {
    String? imageUrl = controller.user.value.profilePicture;
    if (imageUrl != null) {
      await removeImage(imageUrl);
    }
    await instance().collection("users").doc(currentUserId).delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Future<void> deleteUserPosts(String currentUserId) async {
    QuerySnapshot<Map<String, dynamic>> postsQuerySnapshot = await instance()
        .collection('posts')
        .where('creatorId', isEqualTo: currentUserId)
        .get();
    postsQuerySnapshot.docs.forEach((doc) {
      doc['postImages'].forEach((image) async {
        await removeImage(image['url']);
      });
      doc.reference.delete();
    });
  }

  Future<void> removeImage(String imageUrl) async {
    try {
      // Parse the image URL to get the path in Firebase Storage
      // Uri uri = Uri.parse(imageUrl);
      // String imagePath = uri.path;

      // Remove the image file from Firebase Storage
      await storage.refFromURL(imageUrl).delete();
      log("Deleted from storage");

      // You can perform any necessary cleanup here, such as updating the user's data
    } catch (error) {
      print("Error removing image: $error");
      return;
    }
  }

  Future<void> deleteUserReviews(String currentUserId) async {
    QuerySnapshot<Map<String, dynamic>> reviewQuerySnapshot = await instance()
        .collection('reviews')
        .where('userId', isEqualTo: currentUserId)
        .get();
    reviewQuerySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  FirebaseFirestore instance() => FirebaseFirestore.instance;
}

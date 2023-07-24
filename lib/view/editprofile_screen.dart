import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/profile_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:medzo/widgets/pick_image.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    pickImageController pickController = Get.put(pickImageController());

    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
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
                  height: Responsive.height(2, context),
                )),
            title: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                ConstString.editprofile,
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
          body: editProfileWidget(context, controller, pickController),
        );
      },
    );
  }

  Stack editProfileWidget(BuildContext context, ProfileController controller,
      pickImageController pickController) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: pickController.selectedImage.isEmpty
                      ? CircleAvatar(
                          maxRadius: Responsive.height(7, context),
                          backgroundColor: AppColors.blue.withOpacity(0.1),
                          backgroundImage: AssetImage("assets/profile.jpg"),
                        )
                      : ClipOval(
                          child: Container(
                            height: 105,
                            width: 105,
                            child: Image.file(
                              File(pickController.selectedImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: Responsive.height(4, context),
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
                        fontSize: Responsive.sp(4, context),
                        letterSpacing: 0,
                        fontFamily: AppFont.fontMedium),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 25, left: 15),
                child: TextFormField(
                  controller: controller.nameController,
                  cursorColor: AppColors.grey,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    // suffixIcon: Padding(
                    //   padding: const EdgeInsets.only(right: 5),
                    //   child: IconButton(
                    //       onPressed: () {},
                    //       icon: SvgPicture.asset(
                    //         SvgIcon.pencil_simple,
                    //         height: Responsive.height(2.8, context),
                    //       )),
                    // ),
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Enter your name",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: Responsive.sp(3.8, context)),
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
                height: Responsive.height(1.5, context),
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
                        fontSize: Responsive.sp(4, context),
                        letterSpacing: 0,
                        fontFamily: AppFont.fontMedium),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, right: 25, left: 15),
                child: TextFormField(
                  controller: controller.professionController,
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    // suffixIcon: Padding(
                    //   padding: const EdgeInsets.only(right: 5),
                    //   child: IconButton(
                    //       onPressed: () {},
                    //       icon: SvgPicture.asset(
                    //         SvgIcon.pencil_simple,
                    //         height: Responsive.height(2.8, context),
                    //       )),
                    // ),
                    hintText: "Enter your profession",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: Responsive.sp(3.8, context)),
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
                height: Responsive.height(5, context),
              ),
              ElevatedButton(
                onPressed: () async {
                  String name = controller.nameController.text;
                  String profession = controller.professionController.text;

                  try {
                    await UserRepository.getInstance().updateUser(UserModel(
                        name: name,
                        profession: profession,
                        id: FirebaseAuth.instance.currentUser!.uid));
                  } catch (e) {
                    print("Exception Thrown : $e");
                  }

                  showDialog(
                    context: context,
                    builder: (context) {
                      return successDialogue(
                        titleText: "Successful Changed",
                        subtitle: "Your profile has been changed successfully.",
                        iconDialogue: SvgIcon.check_circle,
                        btntext: "Done",
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Responsive.width(50, context),
                        Responsive.height(7, context)),
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: TextWidget(
                  ConstString.save,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.buttontext,
                      fontSize: Responsive.sp(4.2, context)),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 85,
          right: 120,
          child: GestureDetector(
            onTap: () {
              pickController.pickImage(context);
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
                    height: Responsive.height(2.5, context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

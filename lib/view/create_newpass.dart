import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/forgot_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/constants.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:sizer/sizer.dart';

class NewPassword extends GetView {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  final String? email;

  NewPassword(this.email);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  color: AppColors.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logo, height: 40),
                          SizedBox(
                            width: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset(
                              AppImages.medzo,
                              height: 23,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextWidget(
                          ConstString.exploreandknowaboutmedicine,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.white,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 9, child: newPasswordWidget(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container newPasswordWidget(
      ForgotController controller, BuildContext context) {
    return Container(
      height: SizerUtil.height / 1,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: TextWidget(
                    ConstString.createnewpassword,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.newpassworddetail,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Obx(
                    () => TextFormField(
                      autofocus: false,
                      obscureText: controller.hidepass.value,
                      keyboardType: TextInputType.visiblePassword,
                      focusNode: fNode,
                      cursorColor: AppColors.grey,
                      controller: controller.passwordTextController,
                      // style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        filled: true,
                        enabled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SvgPicture.asset(
                            SvgIcon.password,
                            width: 5,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidepass.value =
                                  !controller.hidepass.value;
                            },
                            icon: controller.hidepass.value
                                ? SvgPicture.asset(
                                    SvgIcon.pass_eye,
                                    height: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: Colors.black38,
                                  )),
                        fillColor: fNode.hasFocus
                            ? AppColors.tilecolor
                            : AppColors.splashdetail,
                        hintText: "Enter Password",
                        hintStyle: Theme.of(context).textTheme.headlineSmall,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.txtborder, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          // horizontal: 10,
                          vertical: 17,
                        ),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(
                    () => TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.hidepass2.value,
                      focusNode: fNode1,
                      cursorColor: AppColors.grey,
                      controller: controller.confirmpasswordTextController,
                      // style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        filled: true,
                        enabled: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SvgPicture.asset(
                            SvgIcon.password,
                            width: 5,
                          ),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidepass2.value =
                                  !controller.hidepass2.value;
                            },
                            icon: controller.hidepass2.value
                                ? SvgPicture.asset(
                                    SvgIcon.pass_eye,
                                    height: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    size: 20,
                                    color: Colors.black38,
                                  )),
                        fillColor: fNode1.hasFocus
                            ? AppColors.tilecolor
                            : AppColors.splashdetail,
                        hintText: "Enter Confirm Password",
                        hintStyle: Theme.of(context).textTheme.headlineSmall,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.txtborder, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.white, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          // horizontal: 10,
                          vertical: 17,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: ConstString.passwordstrength,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 11,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFont.fontMedium)),
                  TextSpan(
                      text: "Strong",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.lightgreen,
                          ))
                ])),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.fillcheck,
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: TextWidget(
                      ConstString.passrule1,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.fillcheck,
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: TextWidget(
                      ConstString.passrule2,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.fillcheck,
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: TextWidget(
                      ConstString.passrule3,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () async {
                  String password = controller.passwordTextController.text;
                  String cpassword =
                      controller.confirmpasswordTextController.text;

                  String passResponse = validatePassword(password, cpassword);

                  if (passResponse == "Valid Password") {
                    bool result = await controller.changePassword(
                        email: email!, password: password);

                    if (result) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return successDialogue(
                            titleText: "Change Password",
                            subtitle: "Your password has been changed",
                            iconDialogue: SvgIcon.key,
                            btntext: "Done",
                            onPressed: () {
                              // Get.offAll(() => QuestionScreen());
                              Get.back();
                              Get.back();
                              Get.back();
                            },
                          );
                        },
                      );
                    } else {
                      // showInSnackBar("Error");
                      toast(message: "Error");
                    }
                  } else if (passResponse == "Password Mismatch") {
                    // showInSnackBar("Password are Mismatched", isSuccess: false);
                    toast(message: "Password are Mismatched");
                  } else {
                    // showInSnackBar("Invalid Format", isSuccess: false);
                    toast(message: "Invalid Password Format");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  ConstString.save,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

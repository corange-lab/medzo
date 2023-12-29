import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/constants.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/privacy_policy.dart';
import 'package:medzo/view/terms_condition.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/dialogue.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends GetView<AuthController> {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (ctrl) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
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
                              Image.asset(AppImages.medicineBox1, height: 36),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: SvgPicture.asset(
                                  AppImages.newMedzoLineLogo,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextWidget(
                              ConstString.exploreandknowaboutmedicine,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.white,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 9, child: signUpWidget(ctrl, context)),
                ],
              ),
            ));
      },
    );
  }

  Container signUpWidget(AuthController ctrl, BuildContext context) {
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
                    ConstString.createaccount,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.enterdetailstocontinue,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: TextFormField(
                  autofocus: false,
                  focusNode: fNode,
                  cursorColor: AppColors.grey,
                  enabled: true,
                  controller: controller.supemailTextController,
                  // style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: SvgPicture.asset(
                        SvgIcon.email,
                        width: 5,
                      ),
                    ),
                    fillColor: fNode.hasFocus
                        ? AppColors.tilecolor
                        : AppColors.splashdetail,
                    hintText: "Enter Email Address",
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.white, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.txtborder, width: 0.5),
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
                      horizontal: 10,
                      vertical: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(
                    () => TextFormField(
                      autofocus: false,
                      obscureText: ctrl.hidepass.value,
                      focusNode: fNode1,
                      cursorColor: AppColors.grey,
                      controller: controller.suppasswordTextController,
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
                              ctrl.hidepass.value = !ctrl.hidepass.value;
                            },
                            icon: ctrl.hidepass.value
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
              SizedBox(
                height: 55,
              ),
              ElevatedButton(
                onPressed: () async {
                  String password = controller.suppasswordTextController.text;

                  checkPassword(password);
                  progressDialogue(context, title: "SignUp In Progress");
                  await controller.signUp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  ConstString.sigup,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextWidget(
                    ConstString.orloginwith,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 50,
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.signInWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                          backgroundColor: AppColors.splashdetail,
                          fixedSize: Size(0, 50)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.google,
                              height: 23,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextWidget(
                              ConstString.google,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.signInWithApple();
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                          backgroundColor: AppColors.splashdetail,
                          fixedSize: Size(0, 50)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.apple,
                              height: 23,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            TextWidget(
                              ConstString.apple,
                              style: Theme.of(context).textTheme.bodyLarge,
                            )
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                            "By tapping Continue with Google or Apple, \nyou agree to Medzo ",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontSize: 12.5,
                                height: 1.4)),
                    TextSpan(
                        text: "Terms of Use",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontFamily: AppFont.fontFamilysemi,
                                color: AppColors.darkPrimaryColor,
                                fontSize: 12.5,
                                decoration: TextDecoration.underline,
                                height: 1.4),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => TermsCondition());
                          }),
                    TextSpan(
                        text: " and ",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                color: AppColors.darkPrimaryColor,
                                fontSize: 12.5,
                                height: 1.4)),
                    TextSpan(
                        text: "Privacy Policy",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontFamily: AppFont.fontFamilysemi,
                                color: AppColors.darkPrimaryColor,
                                fontSize: 12.5,
                                decoration: TextDecoration.underline,
                                height: 1.4),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => PrivacyPolicy());
                          }),
                  ])),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: ConstString.alreadyhaveaccount,
                      style: Theme.of(context).textTheme.labelSmall),
                  TextSpan(
                      text: ConstString.login,
                      style: Theme.of(context).textTheme.labelMedium)
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

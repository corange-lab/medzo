import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/forgotpassword.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends GetView<AuthController> {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (ctrl) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor,
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
                            Image.asset(AppImages.logo,
                                height: Responsive.height(4, context)),
                            SizedBox(
                              width: Responsive.width(2, context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: SvgPicture.asset(
                                AppImages.medzo,
                                height: Responsive.height(3, context),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextWidget(
                            ConstString.exploreandknowaboutmedicine,
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(color: AppColors.white,fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 9, child: signInWidget(ctrl, context)),
              ],
            ),
          );
        });
  }

  Container signInWidget(AuthController ctrl, BuildContext context) {
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
              SizedBox(
                height: Responsive.height(0.5, context),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: TextWidget(
                    ConstString.welcomeback,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.enterdetailstocontinue,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: TextField(
                  autofocus: false,
                  focusNode: fNode,
                  cursorColor: AppColors.grey,
                  enabled: true,
                  controller: ctrl.emailTextController,
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
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(
                    () => TextField(
                      autofocus: false,
                      obscureText: ctrl.hidepass.value,
                      focusNode: fNode1,
                      cursorColor: AppColors.grey,
                      controller: ctrl.passwordTextController,
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
                                    height: Responsive.height(2, context),
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 15,
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
                          vertical: 10,
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                    onPressed: () {
                      // Forgot Button
                      Get.to(ForgotScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextWidget(
                        ConstString.forgotpassword,
                        style: TextStyle(
                            fontFamily: AppFont.fontFamily,
                            fontSize: Responsive.sp(2.8, context),
                            color: AppColors.blue,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3),
                      ),
                    )),
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await ctrl.signInWithEmailAndPassword();
                  String email = ctrl.emailTextController.text.trim();
                  String password = ctrl.passwordTextController.text;
                  await ctrl.signUpWithEmailPassword(email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  ConstString.login,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: Responsive.height(5, context),
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
                height: Responsive.height(5, context),
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
                          fixedSize: Size(0, Responsive.height(5.5, context))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.google,
                              height: Responsive.height(2.2, context),
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
                          fixedSize: Size(0, Responsive.height(5.5, context))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.apple,
                              height: Responsive.height(2.2, context),
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
                height: Responsive.height(12, context),
              ),
              TextButton(
                onPressed: () {
                  ctrl.navigateToSignUp();
                },
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: ConstString.didnthaveanaccount,
                      style: Theme.of(context).textTheme.labelSmall),
                  TextSpan(
                      text: ConstString.createaccount,
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

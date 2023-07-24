import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/forgot_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/verify_otp_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class InputEmailForgotPasswordScreen extends GetView<ForgotController> {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  InputEmailForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotController>(
        init: ForgotController(),
        builder: (ctrl) {
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
                            Image.asset(AppImages.logo,
                                height: Responsive.height(5, context)),
                            SizedBox(
                              width: Responsive.width(2, context),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: SvgPicture.asset(
                                AppImages.medzo,
                                height: Responsive.height(2.8, context),
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
                                    fontSize: Responsive.sp(4, context)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 8, child: signInWidget(ctrl, context)),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      ctrl.navigateToSignIn();
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
                ),
              ],
            ),
          );
        });
  }

  Container signInWidget(ForgotController ctrl, BuildContext context) {
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
              // SizedBox(
              //   height: Responsive.height(0.5, context),
              // ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 2),
                  child: TextWidget(
                    ConstString.forgotpassword.replaceAll('?', ''),
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
                height: Responsive.height(2, context),
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
                      vertical: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              ElevatedButton(
                onPressed: () async {
                  // TODO: validate before send otp
                  // TODO: send OTP API Call and handle success failure result here
                  String email = ctrl.emailTextController.text.trim();
                  await Get.to(VerifyOTPScreen(email: email));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  ConstString.sendotp,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                height: Responsive.height(5, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

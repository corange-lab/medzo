import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/forgot_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class ForgotScreen extends GetView<ForgotController> {
  final FocusNode fNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ForgotController>(
      init: ForgotController(),
      builder: (controller) {
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
              Expanded(flex: 9, child: forgotWidget(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container forgotWidget(ForgotController controller, BuildContext context) {
    return Container(
      height: SizerUtil.height / 1,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: TextWidget(
                    ConstString.forgotpassword,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.otpDetails(
                      controller.emailTextController.text.trim()),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: Responsive.height(4, context),
              ),
              controller.pageStatus.value
                  ? SizedBox(
                      height: Responsive.height(6.5, context),
                      child: OtpTextField(
                        numberOfFields: 4,
                        cursorColor: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(28),
                        showFieldAsBox: true,
                        fieldWidth: 72,
                        borderColor: AppColors.primaryColor,
                        enabled: true,
                        filled: true,
                        fillColor: AppColors.splashdetail,
                        keyboardType: TextInputType.number,
                        disabledBorderColor: AppColors.splashdetail,
                        focusedBorderColor: AppColors.primaryColor,
                        enabledBorderColor: AppColors.splashdetail,
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.black26),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: TextField(
                        autofocus: false,
                        focusNode: fNode,
                        cursorColor: AppColors.grey,
                        enabled: true,
                        controller: controller.emailTextController,
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
                            horizontal: 10,
                            vertical: 17,
                          ),
                        ),
                      ),
                    ),
              controller.pageStatus.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          "00 : 29 Sec",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                          onPressed: () {
                            // ctrl.navigateToSignUp();
                          },
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: ConstString.didntreceivecode,
                                style: Theme.of(context).textTheme.labelSmall),
                            TextSpan(
                                text: ConstString.resendit,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontFamily: AppFont.fontMedium,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600)
                                // style: TextStyle(
                                //   fontSize: Resp,
                                //   // 50
                                //   fontFamily: AppFont.fontFamilysemi,
                                //   letterSpacing: 0.6,
                                //   fontWeight: FontWeight.w600,
                                //   color: AppColors.blue,
                                // ),
                                )
                          ])),
                        ),
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    controller.pageStatus.value = true;
                    controller.btnClick++;
                    print(controller.btnClick);
                    if (controller.btnClick == 2) {
                      // Get.off(NewPassword());
                      controller.forgetPassword(
                          controller.emailTextController.text.trim());
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
                    controller.pageStatus.value
                        ? ConstString.continueButton
                        : ConstString.sendotp,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

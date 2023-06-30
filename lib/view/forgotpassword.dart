import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/forgot_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/create_newpass.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class ForgotScreen extends GetView<Forgotcontroller> {
  final FocusNode fNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<Forgotcontroller>(
      init: Forgotcontroller(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ThemeColor.primaryColor,
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 140,
                  color: ThemeColor.primaryColor,
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
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 9, child: ForgotWidget(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container ForgotWidget(Forgotcontroller controller, BuildContext context) {
    return Container(
      height: SizerUtil.height / 1,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Obx(() => Column(
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
                    ConstString.forgotpassword,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.otpdetails,
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
                  cursorColor: ThemeColor.primaryColor,
                  borderRadius: BorderRadius.circular(28),
                  showFieldAsBox: true,
                  fieldWidth: 70,
                  borderColor: ThemeColor.primaryColor,
                  enabled: true,
                  filled: true,
                  fillColor: AppColors.splashdetail,
                  keyboardType: TextInputType.number,
                  disabledBorderColor: AppColors.splashdetail,
                  focusedBorderColor: ThemeColor.primaryColor,
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
                  cursorColor: ThemeColor.grey,
                  enabled: true,
                  // controller: controller.emailTextController,
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
                        ? ThemeColor.tilecolor
                        : AppColors.splashdetail,
                    hintText: "Enter Email Address",
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                    border: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ThemeColor.white, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.txtborder, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ThemeColor.white, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ThemeColor.white, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(1, context),
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
                        style: TextStyle(
                          fontSize: 10,
                          // 50
                          fontFamily: AppFont.fontFamilysemi,
                          letterSpacing: 0.6,
                          fontWeight: FontWeight.w600,
                          color: ThemeColor.blue,
                        ),
                      )
                    ])),
                  ),
                ],
              )
                  : SizedBox(),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              Obx(
                    () => ElevatedButton(
                  onPressed: () async {
                    controller.pageStatus.value = true;
                    Get.off(NewPassword());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColor.primaryColor,
                    elevation: 0,
                    fixedSize: Size(SizerUtil.width, 45),
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
          ),)
        ),
      ),
    );
  }
}

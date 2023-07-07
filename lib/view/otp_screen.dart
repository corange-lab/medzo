import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/otp_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/question_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatelessWidget {
  final String email;
  const OTPScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OTPController(email: email),
      builder: (controller) {
        return OTPScreenWidget(email: email);
      },
    );
  }
}

class OTPScreenWidget extends GetView<OTPController> {
  final String email;
  const OTPScreenWidget({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Expanded(flex: 9, child: otpWidget(context)),
        ],
      ),
    );
  }

  Container otpWidget(BuildContext context) {
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
                    ConstString.verificationotp,
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
              SizedBox(
                height: Responsive.height(6.5, context),
                child: OtpTextField(
                  numberOfFields: 4,
                  cursorColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(28),
                  showFieldAsBox: true,
                  fieldWidth: 70,
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
                      border: OutlineInputBorder(), fillColor: Colors.black26),
                ),
              ),
              SizedBox(
                height: Responsive.height(1, context),
              ),
              Row(
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
                          fontFamily: AppFont.fontFamily,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                        ),
                      )
                    ])),
                  ),
                ],
              ),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.verifyOtp(email: email);
                  //Get.off(QuestionScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(
                  ConstString.verifyotp,
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

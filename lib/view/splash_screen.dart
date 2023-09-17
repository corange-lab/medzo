import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/splash_screen_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetBuilder<SplashScreenController>(
          init: SplashScreenController(),
          builder: (controller) {
            return Scaffold(
                body: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizerUtil.height,
                  width: SizerUtil.width,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    // gradient: LinearGradient(
                    //     colors: GradientThemeColors.orangegradient,
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight),
                    // image: const DecorationImage(
                    //     image: AssetImage(AppImages.splashback),
                    //     fit: BoxFit.fill),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // BounceInDown(
                          //   child: Image.asset(
                          //     AppImages.medicineBox1,
                          //     height: 140,
                          //   ),
                          //   duration: Duration(seconds: 2),
                          //   delay: Duration(seconds: 2),
                          // ),
                          Image.asset(
                            AppImages.medicineBox1,
                            height: 200,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Image.asset(
                            AppImages.medzoLineLogo1,
                            height: 55,
                          ),
                          // ZoomIn(
                          //   child: Image.asset(
                          //     AppImages.medzoLineLogo1,
                          //     height: 70,
                          //   ),
                          //   duration: Duration(seconds: 1),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: Responsive.height(15, context),
                      ),
                      Container(
                        height: Responsive.height(20, context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: TextWidget(
                            "Disclaimer: The reviews and ratings on this app are solely the opinions of the users and are not intended to replace professional medical advice. The information provided on this app should not be used for diagnosis or treatment of any health problem or disease. Please consult your healthcare provider before taking any medication.",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
          },
        );
      },
    );
  }
}

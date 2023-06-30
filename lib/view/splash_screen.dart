import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/splash_screen_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends GetWidget<SplashScreenController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetBuilder<SplashScreenController>(
          init: SplashScreenController(),
          builder: (controller) {
            return Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: SizerUtil.height,
                  width: SizerUtil.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: GradientThemeColors.orangegradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      image: DecorationImage(
                          image: AssetImage(AppImages.splashback))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.logo,
                              height: Responsive.height(8, context)),
                          SizedBox(
                            width: Responsive.width(3.5, context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset(
                              AppImages.medzo,
                              height: Responsive.height(5, context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.height(30, context),),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                        child: TextWidget(
                          "Disclaimer: The reviews and ratings on this app are solely the opinions of the users and are not intended to replace professional medical advice. The information provided on this app should not be used for diagnosis or treatment of any health problem or disease. Please consult your healthcare provider before taking any medication.",
                          style: Theme.of(context).textTheme.displaySmall,
                          // style: TextStyle(
                          //     fontSize: Responsive.sp(2.3, context),
                          //     fontFamily: AppFont.fontFamily,
                          //     color: AppColors.splashdetail,
                          //     letterSpacing: 0.5,
                          //     height: 1.7,
                          //     fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ));
          },
        );
      },
    );
  }
}

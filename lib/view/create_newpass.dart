import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/question_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class NewPassword extends GetView {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
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
              Expanded(flex: 9, child: newPasswordWidget(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container newPasswordWidget(AuthController controller, BuildContext context) {
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
                    ConstString.createnewpassword,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
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
                height: Responsive.height(3, context),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Obx(
                    () => TextField(
                      autofocus: false,
                      obscureText: controller.hidepass.value,
                      focusNode: fNode,
                      cursorColor: AppColors.grey,
                      // controller: ctrl.passwordTextController,
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
                                    height: Responsive.height(2, context),
                                  )
                                : const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 15,
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
                          vertical: 10,
                        ),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Obx(
                    () => TextField(
                      autofocus: false,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: controller.hidepass2.value,
                      focusNode: fNode1,
                      cursorColor: AppColors.grey,
                      // controller: ctrl.passwordTextController,
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
              SizedBox(
                height: Responsive.height(1.5, context),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: ConstString.passwordstrength,
                      style: TextStyle(
                          fontSize: 9,
                          fontFamily: AppFont.fontFamily,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                          color: AppColors.grey),),
                  TextSpan(
                    text: "Strong",
                    style: TextStyle(
                      fontSize: 9,
                      // 50
                      fontFamily: AppFont.fontFamily,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightgreen,
                    ),
                  )
                ])),
              ),
              SizedBox(
                height: Responsive.height(4, context),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.fillcheck,
                    height: Responsive.height(2.5, context),
                  ),
                  SizedBox(
                    width: Responsive.width(3, context),
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
                    height: Responsive.height(2.5, context),
                  ),
                  SizedBox(
                    width: Responsive.width(3, context),
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
                    height: Responsive.height(2.5, context),
                  ),
                  SizedBox(
                    width: Responsive.width(3, context),
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
                height: Responsive.height(4.5, context),
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.off(QuestionScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  fixedSize: Size(SizerUtil.width, 45),
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

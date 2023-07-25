import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/auth_controller.dart';
import 'package:medzo/controller/forgot_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/widgets/dialogue.dart';
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
              Expanded(flex: 9, child: newPasswordWidget(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container newPasswordWidget(ForgotController controller, BuildContext context) {
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
              Align(
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  ConstString.newpassworddetail,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: Responsive.height(2, context),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 5),
                  child: Obx(
                    () => TextFormField(
                      autofocus: false,
                      obscureText: controller.hidepass.value,
                      focusNode: fNode,
                      cursorColor: AppColors.grey,
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Empty';
                        }
                      },
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
                                    height: Responsive.height(2.5, context),
                                  )
                                :  Icon(
                                    Icons.visibility_off_outlined,
                                    size: Responsive.height(2.5, context),
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
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Empty';
                        }
                        if(value != controller.passwordTextController.text){
                          return 'Password Not Match';
                        }
                        return null;
                      },
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
                                    height: Responsive.height(2.5, context),
                                  )
                                :  Icon(
                                    Icons.visibility_off_outlined,
                                    size: Responsive.height(2.5, context),
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
                height: Responsive.height(2, context),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: ConstString.passwordstrength,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: Responsive.sp(2.8, context),
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFont.fontMedium)),
                  TextSpan(
                    text: "Strong",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.lightgreen,)
                  )
                ])),
              ),
              SizedBox(
                height: Responsive.height(3, context),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.fillcheck,
                    height: Responsive.height(2.3, context),
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
                    height: Responsive.height(2.3, context),
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
                    height: Responsive.height(2.3, context),
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return successDialogue(
                        titleText: "Change Password",
                        subtitle: "Your password has been changed",
                        iconDialogue: SvgIcon.key,
                        btntext: "Done",
                        onPressed: () {
                          Get.off(QuestionScreen());
                        },
                      );
                    },
                  );
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

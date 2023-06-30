import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medzo/controller/question_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class Question_screen extends GetView<Question_controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Question_controller>(
      init: Question_controller(),
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
              Expanded(flex: 9, child: con_question(controller, context)),
            ],
          ),
        );
      },
    );
  }

  Container con_question(Question_controller ctrl, BuildContext context) {
    return Container(
      height: SizerUtil.height / 1,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
                flex: 12,
                child: Obx(
                  () => Container(
                    child: PageView.builder(
                      controller: ctrl.pageController.value,
                      onPageChanged: (value) => onPageChanged(ctrl, value),
                      itemCount: ctrl.Questions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: Responsive.height(2, context),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: TextWidget(
                                  ctrl.Questions[ctrl.selectedPageIndex.value]
                                      [0][0],
                                  style: Theme.of(context).textTheme.titleLarge,
                                )),
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    value: "No",
                                    groupValue: ctrl.healthAns.value,
                                    onChanged: (value) {
                                      ctrl.healthAns.value = value!;
                                    },
                                    activeColor: ThemeColor.primaryColor,
                                  ),
                                  TextWidget(
                                    "No",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(3.3, context),
                                        fontFamily: AppFont.fontFamily,
                                        letterSpacing: 0.5,
                                        height: 1.4,
                                        color: ctrl.healthAns.value == "No"
                                            ? ThemeColor.primaryColor
                                            : ThemeColor.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(3, context),
                                  ),
                                  Radio(
                                    value: "Yes",
                                    groupValue: ctrl.healthAns.value,
                                    onChanged: (value) {
                                      ctrl.healthAns.value = value!;
                                    },
                                    activeColor: ThemeColor.primaryColor,
                                  ),
                                  TextWidget(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: Responsive.sp(3.3, context),
                                        fontFamily: AppFont.fontFamily,
                                        letterSpacing: 0.5,
                                        height: 1.4,
                                        color: ctrl.healthAns.value == "Yes"
                                            ? ThemeColor.primaryColor
                                            : ThemeColor.grey,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Responsive.height(1, context),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextWidget(
                                ctrl.Questions[ctrl.selectedPageIndex.value][1]
                                    [0],
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(
                              height: Responsive.height(2, context),
                            ),
                            ctrl.selectedPageIndex.value == 0 ||
                                    ctrl.selectedPageIndex.value == 1
                                ? Obx(() => Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.splashdetail,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      height: Responsive.height(5.5, context),
                                      width: SizerUtil.width,
                                      child: DropdownButton(
                                        underline: SizedBox(),
                                        items: ctrl.healthCondition
                                            .map((String items) {
                                          return DropdownMenuItem<String>(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          ctrl.healthDropdown.value = value!;
                                        },
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 190),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeColor.grey,
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        value: ctrl.healthDropdown.value,
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                    ))
                                : ctrl.selectedPageIndex.value == 2
                                    ? TextField(
                                        autofocus: false,
                                        // focusNode: fnode1,
                                        cursorColor: ThemeColor.grey,
                                        // style: Theme.of(context).textTheme.bodyMedium,
                                        decoration: InputDecoration(
                                          filled: true,
                                          enabled: true,
                                          // fillColor: fnode1.hasFocus
                                          // ? ThemeColor.tilecolor
                                          //     : AppColors.splashdetail,
                                          hintText: "Enter Allergies",
                                          hintStyle: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColor.white,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.txtborder,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColor.white,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ThemeColor.white,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                        ),
                                      )
                                    : ctrl.selectedPageIndex.value == 3
                                        ? Container()
                                        : SizedBox(),
                            SizedBox(
                              height: Responsive.height(2, context),
                            ),
                            ctrl.selectedPageIndex.value != 3
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextWidget(
                                      ctrl.Questions[
                                          ctrl.selectedPageIndex.value][2][0],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      textAlign: TextAlign.left,
                                    ))
                                : SizedBox(),
                            SizedBox(
                              height: Responsive.height(2, context),
                            ),
                            ctrl.selectedPageIndex.value != 3
                                ? ctrl.selectedPageIndex.value == 0 || ctrl.selectedPageIndex.value == 1 ? Obx(() => Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.splashdetail,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      height: Responsive.height(5.5, context),
                                      width: SizerUtil.width,
                                      child: DropdownButton(
                                        underline: SizedBox(),
                                        items: ctrl.year.map((String items) {
                                          return DropdownMenuItem<String>(
                                            value: items,
                                            child: Text(items),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          ctrl.yearDropdown.value = value!;
                                        },
                                        icon: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 220),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: ThemeColor.grey,
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        value: ctrl.yearDropdown.value,
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                    ))
                                : SizedBox() : TextField(
                              autofocus: false,
                              // focusNode: fnode1,
                              cursorColor: ThemeColor.grey,
                              // style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                filled: true,
                                enabled: true,
                                // fillColor: fnode1.hasFocus
                                // ? ThemeColor.tilecolor
                                //     : AppColors.splashdetail,
                                hintText: "Enter Allergies",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColor.white,
                                      width: 0.5),
                                  borderRadius:
                                  BorderRadius.circular(7),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.txtborder,
                                      width: 0.5),
                                  borderRadius:
                                  BorderRadius.circular(7),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColor.white,
                                      width: 0.5),
                                  borderRadius:
                                  BorderRadius.circular(7),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ThemeColor.white,
                                      width: 0.5),
                                  borderRadius:
                                  BorderRadius.circular(7),
                                ),
                                contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )),
            Obx(
              () => Expanded(
                flex: 1,
                child: ctrl.selectedPageIndex.value == 0
                    ? ElevatedButton(
                        onPressed: () async {
                          if (ctrl.selectedPageIndex.value == 0) {
                            controller.pageController.value.animateToPage(1,
                                duration: Duration(milliseconds: 10),
                                curve: Curves.easeInOut);
                          } else if (ctrl.selectedPageIndex.value == 1) {
                            controller.pageController.value.animateToPage(2,
                                duration: Duration(milliseconds: 10),
                                curve: Curves.easeInOut);
                          } else if (ctrl.selectedPageIndex.value == 2) {
                            controller.pageController.value.animateToPage(3,
                                duration: Duration(milliseconds: 10),
                                curve: Curves.easeInOut);
                          } else {
                            Get.off(const HomeScreen());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.primaryColor,
                          elevation: 0,
                          fixedSize: Size(SizerUtil.width, 45),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          ConstString.next,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (ctrl.selectedPageIndex.value == 1) {
                                  controller.pageController.value.animateToPage(
                                      0,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else if (ctrl.selectedPageIndex.value == 2) {
                                  controller.pageController.value.animateToPage(
                                      1,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else if (ctrl.selectedPageIndex.value == 3) {
                                  controller.pageController.value.animateToPage(
                                      2,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else {
                                  controller.pageController.value.animateToPage(
                                      0,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.splashdetail,
                                elevation: 0,
                                fixedSize: Size(SizerUtil.width, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              child: Text(
                                ConstString.back,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width(3, context),
                          ),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (ctrl.selectedPageIndex.value == 0) {
                                  controller.pageController.value.animateToPage(
                                      1,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else if (ctrl.selectedPageIndex.value == 1) {
                                  controller.pageController.value.animateToPage(
                                      2,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else if (ctrl.selectedPageIndex.value == 2) {
                                  controller.pageController.value.animateToPage(
                                      3,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut);
                                } else {
                                  Get.off(const HomeScreen());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColor.primaryColor,
                                elevation: 0,
                                fixedSize: Size(SizerUtil.width, 45),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              child: Text(
                                ctrl.selectedPageIndex.value == 3
                                    ? ConstString.savencontinue
                                    : ConstString.next,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChanged(Question_controller controller, int? value) {
    controller.selectedPageIndex.value = value ?? 0;
    // print('value $value');
    // if (controller.selectedPageIndex.value == 3) {
    //   navigateToHome();
    // }
  }
}

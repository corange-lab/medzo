import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:medzo/controller/question_controller.dart';
import 'package:medzo/model/age_group.dart';
import 'package:medzo/model/allergies.dart';
import 'package:medzo/model/current_medication.dart';
import 'package:medzo/model/health_condition.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/home_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends GetView<QuestionController> {
  final FocusNode fNode = FocusNode();
  final FocusNode fNode1 = FocusNode();

  final int currentQuestionnairesPosition;
  QuestionScreen({super.key, this.currentQuestionnairesPosition = 0});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
      init: QuestionController(
          currentQuestionnairesPosition: currentQuestionnairesPosition),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Responsive.height(7, context),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              screenTitle(controller, context),
                              GestureDetector(
                                onTap: () async =>
                                    await skipQuestion(controller),
                                child: Row(
                                  children: [
                                    TextWidget(
                                      ConstString.skipButton,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: AppColors.darkyellow,
                                              fontSize:
                                                  Responsive.sp(3.8, context)),
                                    ),
                                    Icon(
                                      CupertinoIcons.right_chevron,
                                      size: Responsive.height(2, context),
                                      color: AppColors.darkyellow,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Responsive.height(3, context)),
                        screenProgressBar(context, controller)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(flex: 9, child: questionWidget(controller, context)),
            ],
          ),
          bottomSheet: Container(
            color: AppColors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: Obx(
              () => controller.selectedPageIndex.value == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async => await saveAndNext(controller),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          elevation: 0,
                          fixedSize: Size(SizerUtil.width, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          ConstString.next,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () => back(controller),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.splashdetail,
                                  elevation: 0,
                                  fixedSize: Size(SizerUtil.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                child: Text(
                                  ConstString.back,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ElevatedButton(
                                onPressed: () async =>
                                    await saveAndNext(controller),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  elevation: 0,
                                  fixedSize: Size(SizerUtil.width, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                                child: Text(
                                  controller.selectedPageIndex.value == 3
                                      ? ConstString.savencontinue
                                      : ConstString.next,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  Future<void> back(QuestionController controller) async {
    if (controller.selectedPageIndex.value == 1) {
      await animateToSpecifiedPage(controller, 0);
    } else if (controller.selectedPageIndex.value == 2) {
      await animateToSpecifiedPage(controller, 1);
    } else if (controller.selectedPageIndex.value == 3) {
      await animateToSpecifiedPage(controller, 2);
    } else {
      await animateToSpecifiedPage(controller, 0);
    }
  }

  Obx screenTitle(QuestionController controller, BuildContext context) {
    return Obx(
      () => TextWidget(
        controller.questionTopic[controller.selectedPageIndex.value],
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(fontSize: Responsive.sp(4.3, context), letterSpacing: 0),
      ),
    );
  }

  Obx screenProgressBar(BuildContext context, QuestionController controller) {
    return Obx(() => GFProgressBar(
          lineHeight: 6,
          width: Responsive.width(86, context),
          percentage: controller.selectedPageIndex.value == 0
              ? 0.25
              : controller.selectedPageIndex.value == 1
                  ? 0.5
                  : controller.selectedPageIndex.value == 2
                      ? 0.75
                      : controller.selectedPageIndex.value == 3
                          ? 1
                          : 1,
          backgroundColor: AppColors.lightprimary,
          progressBarColor: AppColors.white,
        ));
  }

  Future<void> saveAndNext(QuestionController controller) async {
    if (controller.selectedPageIndex.value == 0) {
      await animateToSpecifiedPage(controller, 1);
      controller.userModel = controller.userModel.copyWith(
        healthCondition: HealthCondition(
          healthCondition: controller.healthDropdown.value,
          doesHealthCondition: controller.healthAns.value,
          healthConditionDuration: controller.yearDropdown.value,
        ),
      );
    } else if (controller.selectedPageIndex.value == 1) {
      await animateToSpecifiedPage(controller, 2);
      controller.userModel = controller.userModel.copyWith(
        currentMedication: CurrentMedication(
          currentTakingMedicine: controller.healthDropdown.value,
          durationTakingMedicine: controller.yearDropdown.value,
          takingMedicine: controller.healthAns.value,
        ),
      );
    } else if (controller.selectedPageIndex.value == 2) {
      await animateToSpecifiedPage(controller, 3);
      controller.userModel = controller.userModel.copyWith(
        allergies: Allergies(
          currentAllergies: controller.allergiesController.text.trim(),
          haveAllergies: controller.healthAns.value,
          howSeverAllergies: controller.howSeverAllergiesController.text.trim(),
        ),
      );
    } else {
      controller.userModel = controller.userModel.copyWith(
        ageGroup: AgeGroup(
          age: int.tryParse(controller.ageController.text.trim()) ?? 0,
        ),
      );
      Get.off(() => HomeScreen());
    }
    await controller.updateData();
    return;
  }

  Future<void> skipQuestion(QuestionController controller) async {
    if (controller.selectedPageIndex.value == 0) {
      await animateToSpecifiedPage(controller, 1);
      controller.userModel = controller.userModel.copyWith(
        healthCondition: false,
      );
    } else if (controller.selectedPageIndex.value == 1) {
      await animateToSpecifiedPage(controller, 2);
      controller.userModel = controller.userModel.copyWith(
        currentMedication: false,
      );
    } else if (controller.selectedPageIndex.value == 2) {
      await animateToSpecifiedPage(controller, 3);
      controller.userModel = controller.userModel.copyWith(
        allergies: false,
      );
    } else {
      controller.userModel = controller.userModel.copyWith(
        ageGroup: false,
      );
      Get.offAll(() => HomeScreen());
    }
    await controller.updateData();
    return;
  }

  Future<void> animateToSpecifiedPage(
      QuestionController controller, int index) async {
    return await controller.pageController.value.animateToPage(index,
        duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
  }

  Container questionWidget(QuestionController ctrl, BuildContext context) {
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
                flex: 11,
                child: Obx(
                  () => PageView.builder(
                    controller: ctrl.pageController.value,
                    onPageChanged: (value) => onPageChanged(ctrl, value),
                    itemCount: ctrl.questions.length,
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
                                ctrl.questions[ctrl.selectedPageIndex.value][0],
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          Obx(
                            () => controller.selectedPageIndex.value == 3
                                ? Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextFormField(
                                      autofocus: false,
                                      keyboardType: TextInputType.number,
                                      controller: ctrl.ageController,
                                      cursorColor: AppColors.grey,
                                      decoration: InputDecoration(
                                        filled: true,
                                        enabled: true,
                                        hintText: "Enter Age",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.white,
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
                                              color: AppColors.white,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.white,
                                              width: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                      ),
                                    ),
                                  )
                                : radioControllerWidget(ctrl, context, (value) {
                                    // if (controller.selectedPageIndex.value ==
                                    //     0) {
                                    //   ctrl.healthAns.value = value;
                                    // } else if (controller
                                    //         .selectedPageIndex.value ==
                                    //     1) {
                                    //   // ctrl.medicineAns.value = value;
                                    // } else if (controller
                                    //         .selectedPageIndex.value ==
                                    //     2) {
                                    //   // ctrl.allergyAns.value = value;
                                    // }
                                  }),
                          ),
                          SizedBox(
                            height: Responsive.height(1.5, context),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextWidget(
                              ctrl.questions[ctrl.selectedPageIndex.value][1],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.height(1, context),
                          ),
                          ctrl.selectedPageIndex.value == 0 ||
                                  ctrl.selectedPageIndex.value == 1
                              ? questionDropdown(context, ctrl)
                              : ctrl.selectedPageIndex.value == 2
                                  ? allergiesInputWidget(ctrl, context)
                                  : ctrl.selectedPageIndex.value == 3
                                      ? ageGroupWidget(context, ctrl)
                                      : const SizedBox(),
                          SizedBox(
                            height: Responsive.height(2.5, context),
                          ),
                          ctrl.selectedPageIndex.value != 3
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextWidget(
                                    ctrl.questions[ctrl.selectedPageIndex.value]
                                        [2],
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    textAlign: TextAlign.left,
                                  ))
                              : const SizedBox(),
                          SizedBox(
                            height: Responsive.height(1, context),
                          ),
                          ctrl.selectedPageIndex.value != 3
                              ? ctrl.selectedPageIndex.value == 0 ||
                                      ctrl.selectedPageIndex.value == 1
                                  ? Obx(() => Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.splashdetail,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        height: Responsive.height(6, context),
                                        width: SizerUtil.width,
                                        child: DropdownButton(
                                          underline: const SizedBox(),
                                          items: ctrl.year.map((String items) {
                                            return DropdownMenuItem<String>(
                                              value: items,
                                              child: TextWidget(
                                                items,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                        fontSize: Responsive.sp(
                                                            3.8, context),
                                                        color: AppColors.black),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            ctrl.yearDropdown.value = value!;
                                          },
                                          icon: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 215),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontSize: Responsive.sp(
                                                      3.5, context)),
                                          value: ctrl.yearDropdown.value,
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                        ),
                                      ))
                                  : ctrl.selectedPageIndex.value == 2
                                      ? howSeverAllergiesController(
                                          ctrl, context)
                                      : const SizedBox()
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Obx questionDropdown(BuildContext context, QuestionController ctrl) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: AppColors.splashdetail,
              borderRadius: BorderRadius.circular(30)),
          height: Responsive.height(6, context),
          width: SizerUtil.width,
          child: DropdownButton(
            underline: const SizedBox(),
            items: ctrl.healthCondition.map((String items) {
              return DropdownMenuItem<String>(
                value: items,
                child: TextWidget(
                  items,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: Responsive.sp(3.8, context),
                      color: AppColors.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              ctrl.healthDropdown.value = value!;
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 180),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.grey,
              ),
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: Responsive.sp(3.5, context)),
            value: ctrl.healthDropdown.value,
            padding: const EdgeInsets.only(left: 15),
          ),
        ));
  }

  TextFormField allergiesInputWidget(
      QuestionController ctrl, BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: ctrl.allergiesController,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
        filled: true,
        enabled: true,
        hintText: "Enter Allergies",
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.txtborder, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
      ),
    );
  }

  SizedBox ageGroupWidget(BuildContext context, QuestionController ctrl) {
    return SizedBox(
      height: Responsive.height(10, context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisExtent: 30,
              crossAxisSpacing: 10,
              mainAxisSpacing: 7),
          itemBuilder: (context, index) {
            return Obx(() => InkWell(
                  onTap: () {
                    ctrl.selectedAge.value = ctrl.ageGroup[index];
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ctrl.selectedAge.value == ctrl.ageGroup[index]
                            ? AppColors.tilecolor
                            : AppColors.splashdetail,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "${ctrl.ageGroup[index]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: AppFont.fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: ctrl.selectedAge.value == ctrl.ageGroup[index]
                            ? AppColors.primaryColor
                            : AppColors.grey,
                      ),
                    ),
                  ),
                ));
          },
          itemCount: ctrl.ageGroup.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  TextFormField howSeverAllergiesController(
      QuestionController ctrl, BuildContext context) {
    return TextFormField(
      controller: ctrl.howSeverAllergiesController,
      autofocus: false,
      maxLines: 5,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
        filled: true,
        enabled: true,
        hintText: "Enter Description",
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.txtborder, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.5),
          borderRadius: BorderRadius.circular(7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
    );
  }

  Row radioControllerWidget(QuestionController ctrl, BuildContext context,
      void Function(bool value) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: false,
          groupValue: ctrl.healthAns.value,
          onChanged: (value) {
            ctrl.healthAns.value = value ?? false;
            // onChanged(value!);
          },
          activeColor: AppColors.primaryColor,
        ),
        TextWidget(
          "No",
          style: TextStyle(
              fontSize: Responsive.sp(3.3, context),
              fontFamily: AppFont.fontFamily,
              letterSpacing: 0.5,
              height: 1.4,
              color: !ctrl.healthAns.value
                  ? AppColors.primaryColor
                  : AppColors.grey,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: Responsive.width(3, context),
        ),
        Radio(
          value: true,
          groupValue: ctrl.healthAns.value,
          onChanged: (value) {
            ctrl.healthAns.value = value ?? true;
            // onChanged(value!);
          },
          activeColor: AppColors.primaryColor,
        ),
        TextWidget(
          "Yes",
          style: TextStyle(
              fontSize: Responsive.sp(3.3, context),
              fontFamily: AppFont.fontFamily,
              letterSpacing: 0.5,
              height: 1.4,
              color: ctrl.healthAns.value
                  ? AppColors.primaryColor
                  : AppColors.grey,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void onPageChanged(QuestionController controller, int? value) {
    controller.selectedPageIndex.value = value ?? 0;
  }
}

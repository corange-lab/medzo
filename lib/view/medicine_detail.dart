// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/review_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class MedicineDetail extends StatefulWidget {
  const MedicineDetail({super.key});

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail>
    with TickerProviderStateMixin {
  late TabController tabController;
  late TabController tabQuestionController;

  HomeController homecontroller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabQuestionController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              SvgIcon.backarrow,
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextWidget(
              // FIXME: add Medicine Name
              "Azithromycin",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: Responsive.sp(4.5, context),
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: medicineWidget(
          context, tabController, tabQuestionController, homecontroller),
    );
  }
}

Container medicineWidget(BuildContext context, TabController tabController,
    TabController tabQuestionController, HomeController homeController) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              height: Responsive.height(17, context),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.splashdetail),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Responsive.width(3, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        height: Responsive.height(7, context),
                        child: Image.asset(AppImages.pill),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(1, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            // FIXME: add Medicine Name
                            "Azithromycin",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: Responsive.sp(4, context),
                                    color: AppColors.darkPrimaryColor,
                                    fontFamily: AppFont.fontBold,
                                    letterSpacing: 0),
                          ),
                          SizedBox(
                            height: Responsive.height(0.3, context),
                          ),
                          TextWidget(
                            // FIXME: add Medicine details
                            "A fast acting antibiotic.\nTackles infections effectively",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    height: 1.5,
                                    color: AppColors.grey,
                                    fontFamily: AppFont.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    fontSize: Responsive.sp(3.2, context)),
                          ),
                          SizedBox(
                            height: Responsive.height(0.5, context),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2.8, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2.8, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2.8, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2.8, context),
                              ),
                              Icon(
                                Icons.star_outline_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2.8, context),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Responsive.height(1, context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                SvgIcon.pill,
                                color: AppColors.primaryColor,
                                height: Responsive.height(1.8, context),
                              ),
                              SizedBox(
                                width: Responsive.width(1.5, context),
                              ),
                              TextWidget(
                                // FIXME: add Medicine Type
                                ConstString.antibiotic,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                      fontSize: Responsive.sp(3.2, context),
                                    ),
                              ),
                              SizedBox(
                                width: Responsive.width(3, context),
                              ),
                              SvgPicture.asset(
                                SvgIcon.Rx,
                                color: AppColors.primaryColor,
                                height: Responsive.height(1.6, context),
                              ),
                              SizedBox(
                                width: Responsive.width(1.5, context),
                              ),
                              TextWidget(
                                // FIXME: add Medicine Type
                                ConstString.prescribed,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                      fontSize: Responsive.sp(3.2, context),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => GestureDetector(
                        onTap: () {
                          if (homeController.isSaveMedicine[0]) {
                            homeController.isSaveMedicine[0] = false;
                          } else {
                            homeController.isSaveMedicine[0] = true;
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            height: 38,
                            width: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.splashdetail),
                            child: Padding(
                              padding: homeController.isSaveMedicine[0]
                                  ? EdgeInsets.all(8.0)
                                  : EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                homeController.isSaveMedicine[0]
                                    ? SvgIcon.bookmark
                                    : SvgIcon.fillbookmark,
                                height: Responsive.height(2, context),
                                color: homeController.isSaveMedicine[0]
                                    ? Colors.black
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(1, context),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          TabBar(
            labelPadding: EdgeInsets.all(3),
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            labelColor: AppColors.primaryColor,
            labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: Responsive.sp(3.4, context),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontFamily: AppFont.fontFamily),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
                    fontSize: Responsive.sp(3.4, context),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    fontFamily: AppFont.fontFamily),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.tilecolor,
            ),
            onTap: (value) {
              tabController.index = value;
            },
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                text: "Review",
                height: Responsive.height(4, context),
              ),
              Tab(
                text: "Q&A",
                height: Responsive.height(4, context),
              ),
              Tab(
                text: "About",
                height: Responsive.height(4, context),
              ),
              Tab(
                text: "Warning",
                height: Responsive.height(4, context),
              ),
            ],
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Container(
            width: SizerUtil.width,
            color: AppColors.grey.withOpacity(0.3),
            height: 0.5,
          ),
          SizedBox(
            height: Responsive.height(0.7, context),
          ),
          Expanded(
            child: SizedBox(
                height: Responsive.height(60, context),
                child: TabBarView(controller: tabController, children: [
                  reviewWidget(context),
                  questionWidget(context, tabQuestionController),
                  aboutWidget(context),
                  warningWidget(context),
                ])),
          )
        ],
      ),
    ),
  );
}

Container warningWidget(context) {
  return Container(
    height: Responsive.height(30, context),
    margin: const EdgeInsets.only(bottom: 150, left: 10, right: 10, top: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.splashdetail),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextWidget(
              // FIXME: add Medicine warning
              "Cetirizine, in general, has a low potential for interactions with other drugs. However, certain substances could potentially interact with cetirizine, including",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: Responsive.sp(3.6, context),
                    fontWeight: FontWeight.w400,
                    fontFamily: AppFont.fontMedium,
                    height: 1.6,
                    color: AppColors.dark,
                  ),
              textAlign: TextAlign.start,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: Responsive.height(9, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            SvgIcon.alcohol,
                            height: Responsive.height(3.2, context),
                          ),
                          TextWidget(
                            ConstString.alcohol,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: AppColors.grey,
                                    fontSize: Responsive.sp(3.1, context)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: Responsive.height(9, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            SvgIcon.pill,
                            height: Responsive.height(3.2, context),
                          ),
                          TextWidget(
                            ConstString.maoi,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: AppColors.grey,
                                    fontSize: Responsive.sp(3.1, context)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      height: Responsive.height(9, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            SvgIcon.snowflack,
                            height: Responsive.height(3.1, context),
                          ),
                          TextWidget(
                            ConstString.therphy,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: AppColors.grey,
                                    fontSize: Responsive.sp(3, context)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SizedBox(
                      height: Responsive.height(9, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            SvgIcon.Rx,
                            height: Responsive.height(2.8, context),
                            color: AppColors.grey,
                          ),
                          TextWidget(
                            ConstString.drugs,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: AppColors.grey,
                                    fontSize: Responsive.sp(3.1, context)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextWidget(
            ConstString.clickicon,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  height: 1.5,
                  fontFamily: AppFont.fontFamilysemi,
                  fontSize: Responsive.sp(3.6, context),
                  color: AppColors.orange,
                ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ),
  );
}

Container aboutWidget(context) {
  return Container(
    height: Responsive.height(55, context),
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.splashdetail),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextWidget(
                // FIXME: add Details about Medicine
                "Cetirizine is an over-the-counter antihistamine used to relieve allergy symptoms such as runny nose, sneezing, itching, watery eyes, and itching of the nose or throat. It also can help relieve itching and swelling caused by chronic urticaria (hives). Cetirizine works by blocking the effects of histamine, a substance in the body that causes allergy symptoms.",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: Responsive.sp(3.6, context),
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.fontMedium,
                      height: 1.6,
                      color: AppColors.dark,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: Responsive.height(1.5, context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextWidget(// FIXME: add Medicine details
                "Although Cetirizine is generally considered safe for use, the manufacturers often list several",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: Responsive.sp(3.5, context),
                      height: 1.5,
                      color: AppColors.dark,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextWidget(
                  // FIXME: add Medicine Details
                  "potential warnings and precautions",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: Responsive.sp(3.6, context),
                        height: 1.5,
                        color: AppColors.primaryColor,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: Responsive.height(9, context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pass_eye,
                              height: Responsive.height(3.2, context),
                            ),
                            TextWidget(
                              ConstString.drowsiness,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.2, context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: Responsive.height(9, context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.baby,
                              height: Responsive.height(3.3, context),
                            ),
                            TextWidget(
                              ConstString.pregnancy,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.2, context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: Responsive.height(9, context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pill,
                              height: Responsive.height(3.1, context),
                            ),
                            TextWidget(
                              ConstString.allergy,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.2, context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: Responsive.height(9, context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(SvgIcon.masksad,
                                height: Responsive.height(3.2, context)),
                            TextWidget(
                              ConstString.olderage,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(3.2, context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            TextWidget(
              ConstString.clickicon,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    height: 1.5,
                    fontSize: Responsive.sp(3.6, context),
                    fontFamily: AppFont.fontFamilysemi,
                    color: AppColors.orange,
                  ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    ),
  );
}

Container questionWidget(context, TabController tabQuestionController) {
  //TODO : Remove Q&A Tab
  return Container(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: SizerUtil.height,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.splashdetail),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  SvgIcon.expert,
                  height: Responsive.height(4.5, context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      ConstString.ask,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: Responsive.sp(3.2, context),
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFont.fontMedium),
                    ),
                    SizedBox(
                      width: Responsive.width(0.5, context),
                    ),
                    SvgPicture.asset(
                      SvgIcon.verify,
                      color: AppColors.sky,
                      height: 13,
                    )
                  ],
                ),
                SizedBox(
                  height: Responsive.height(1.5, context),
                ),
                SizedBox(
                  height: Responsive.height(6.5, context),
                  child: TextFormField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      filled: true,
                      enabled: true,
                      suffixIcon: SizedBox(
                        height: Responsive.height(3, context),
                        width: Responsive.width(23, context),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, right: 8),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                elevation: 0,
                                backgroundColor: AppColors.primaryColor,
                                fixedSize: const Size(60, 5)),
                            child: Text(
                              ConstString.submit,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      letterSpacing: 0.2,
                                      fontSize: Responsive.sp(3.2, context),
                                      fontFamily: AppFont.fontFamily,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      fillColor: AppColors.searchbar.withOpacity(0.5),
                      hintText: "Write a question...",
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.grey.withOpacity(0.1), width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.grey.withOpacity(0.1), width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.grey.withOpacity(0.1), width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.grey.withOpacity(0.1), width: 0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(3, context),
                ),
                Container(
                  height: 1,
                  color: AppColors.grey.withOpacity(0.1),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgIcon.chat2,
                      height: Responsive.height(2.5, context),
                    ),
                    SizedBox(
                      width: Responsive.width(2, context),
                    ),
                    TextWidget(
                      ConstString.popularquestions,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.blacktxt,
                          fontSize: Responsive.sp(4.3, context),
                          fontFamily: AppFont.fontFamilysemi,
                          letterSpacing: 0),
                    ),
                  ],
                ),
                SizedBox(
                  height: Responsive.height(3.5, context),
                ),
                TabBar(
                  controller: tabQuestionController,
                  physics: const BouncingScrollPhysics(),
                  labelColor: AppColors.primaryColor,
                  labelPadding: EdgeInsets.all(5),
                  labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: Responsive.sp(3.5, context),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                      fontFamily: AppFont.fontMedium),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                          fontSize: Responsive.sp(3.5, context),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.3,
                          fontFamily: AppFont.fontMedium),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.tilecolor,
                  ),
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    Tab(
                      text: "All",
                      height: Responsive.height(4, context),
                    ),
                    Tab(
                      text: "My Questions",
                      height: Responsive.height(4, context),
                    ),
                  ],
                ),
                SizedBox(
                  height: Responsive.height(1.5, context),
                ),
                Container(
                  height: 1,
                  color: AppColors.grey.withOpacity(0.1),
                ),
                SizedBox(
                    height: Responsive.height(245, context),
                    child: TabBarView(
                        controller: tabQuestionController,
                        children: [
                          popularQuestionWidget(context),
                          popularQuestionWidget(context)
                        ]))
              ]),
        ),
      ),
    ),
  ));
}

Container popularQuestionWidget(context) {
  return Container(
    height: Responsive.height(250, context),
    child: ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            alignment: Alignment.center,
            height: Responsive.height(46, context),
            decoration: BoxDecoration(
                color: AppColors.splashdetail.withOpacity(0.5),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                    width: 1, color: AppColors.lightGrey.withOpacity(0.1))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: CircleAvatar(
                          backgroundColor: AppColors.grey.withOpacity(0.3),
                          child: Icon(
                            Icons.person,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.width(3, context),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              // FIXME: add Name of Review User
                              "John Doe",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: Responsive.sp(3.8, context),
                                    fontFamily: AppFont.fontBold,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: Responsive.height(0.8, context),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextWidget(
                              // FIXME: add Review Time
                              "2 Days Ago",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3, context),
                                      letterSpacing: 0),
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          SvgIcon.arrowup,
                          height: Responsive.height(2.2, context),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextWidget(
                          // FIXME: add User Review
                          "How much does should my 7 years old son take ?",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  height: 1.5,
                                  letterSpacing: 0.3,
                                  fontFamily: AppFont.fontFamilysemi,
                                  fontSize: Responsive.sp(3.7, context)),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          SvgIcon.pen,
                          height: Responsive.height(2.5, context),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          SvgIcon.delete,
                          height: Responsive.height(2.2, context),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Responsive.width(1, context),
                    )
                  ],
                ),
                SizedBox(
                  height: Responsive.height(1, context),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Container(
                    height: Responsive.height(14.5, context),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: AppColors.lightGrey.withOpacity(0.2)),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CircleAvatar(
                                  maxRadius: 16,
                                  backgroundColor:
                                      AppColors.purple.withOpacity(0.1),
                                  child: Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.purple.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.width(3, context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        "Flores, Juanita",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              fontFamily:
                                                  AppFont.fontFamilysemi,
                                              letterSpacing: 0.2,
                                              fontSize:
                                                  Responsive.sp(3.4, context),
                                            ),
                                      ),
                                      SizedBox(
                                        width: Responsive.width(1, context),
                                      ),
                                      SvgPicture.asset(
                                        SvgIcon.verify,
                                        color: AppColors.purple,
                                        height: Responsive.height(1.5, context),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Responsive.height(0.7, context),
                                  ),
                                  TextWidget(
                                    "2 Days Ago",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            letterSpacing: 0,
                                            fontSize:
                                                Responsive.sp(2.8, context),
                                            color: AppColors.grey
                                                .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
                            child: TextWidget(
                              "Yes, that is completely fine, make sure to take right dosages.",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3.3, context),
                                      height: 1.6,
                                      color: AppColors.dark),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Container(
                    height: Responsive.height(14.5, context),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: AppColors.lightGrey.withOpacity(0.2)),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: CircleAvatar(
                                  maxRadius: 16,
                                  backgroundColor:
                                      AppColors.purple.withOpacity(0.1),
                                  child: Icon(
                                    Icons.person,
                                    size: 18,
                                    color: AppColors.purple.withOpacity(0.8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.width(3, context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      TextWidget(
                                        "Cooper, Kristin",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(
                                              fontFamily:
                                                  AppFont.fontFamilysemi,
                                              letterSpacing: 0.2,
                                              fontSize:
                                                  Responsive.sp(3.4, context),
                                            ),
                                      ),
                                      SizedBox(
                                        width: Responsive.width(1, context),
                                      ),
                                      SvgPicture.asset(
                                        SvgIcon.verify,
                                        color: AppColors.purple,
                                        height: Responsive.height(1.5, context),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Responsive.height(0.7, context),
                                  ),
                                  TextWidget(
                                    "2 Days Ago",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            letterSpacing: 0,
                                            fontSize:
                                                Responsive.sp(2.8, context),
                                            color: AppColors.grey
                                                .withOpacity(0.5)),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
                            child: TextWidget(
                              "Yes, that is completely fine, make sure to take right dosages.",
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: Responsive.sp(3.3, context),
                                      height: 1.6,
                                      color: AppColors.dark),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

Container reviewWidget(context) {
  return Container(
    child: Stack(
      children: [
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: Responsive.height(61, context),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.splashdetail),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextWidget(ConstString.mostrecent,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: AppColors.grey,
                                          fontFamily: AppFont.fontMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Responsive.sp(3.5, context),
                                          letterSpacing: 0.3)),
                              SizedBox(
                                width: Responsive.width(1.5, context),
                              ),
                              SvgPicture.asset(
                                SvgIcon.arrowdown,
                                height: Responsive.height(2, context),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(3, context),
                              ),
                              SizedBox(
                                width: Responsive.width(1.5, context),
                              ),
                              TextWidget(
                                // FIXME: add review rating
                                "3.9/5",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        fontSize: Responsive.sp(4.8, context),
                                        fontFamily: AppFont.fontFamilysemi),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: Responsive.height(1, context),
                      ),
                      Container(
                        height: 1,
                        color: AppColors.grey.withOpacity(0.1),
                      ),
                      SizedBox(
                        height: Responsive.height(2, context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              maxRadius: 22,
                              backgroundColor: AppColors.tilecolor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: Responsive.width(4, context),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  // FIXME: add name of review user
                                  "John Doe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontFamily: AppFont.fontBold,
                                          fontSize:
                                              Responsive.sp(3.8, context)),
                                ),
                                SizedBox(
                                  height: Responsive.height(0.5, context),
                                ),
                                TextWidget(
                                  // FIXME: add review details
                                  "Closest Match • Caucasian Male, 61",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: AppColors.grey,
                                          fontFamily: AppFont.fontMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Responsive.sp(3, context)),
                                ),
                                SizedBox(
                                  height: Responsive.height(0.5, context),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Responsive.height(0.8, context),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextWidget(
                          // FIXME: add User Review
                          "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  height: 1.7,
                                  fontSize: Responsive.sp(3.4, context),
                                  fontFamily: AppFont.fontMedium,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.dark),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: () {},
                            child: TextWidget(
                              ConstString.viewreply,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: Responsive.sp(3.5, context),
                                      fontFamily: AppFont.fontFamilysemi,
                                      letterSpacing: 0.2),
                            )),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 1,
                          width: Responsive.width(60, context),
                          color: AppColors.grey.withOpacity(0.1),
                        ),
                      ),
                      SizedBox(
                        height: Responsive.height(1.5, context),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              maxRadius: 22,
                              backgroundColor: AppColors.tilecolor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: Responsive.width(4, context),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  // FIXME: add name of review user
                                  "John Doe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontFamily: AppFont.fontBold,
                                          fontSize:
                                              Responsive.sp(3.8, context)),
                                ),
                                SizedBox(
                                  height: Responsive.height(0.5, context),
                                ),
                                TextWidget(
                                  // FIXME: add Review user
                                  "Closest Match • Caucasian Male, 61",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color: AppColors.grey,
                                          fontFamily: AppFont.fontMedium,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Responsive.sp(3, context)),
                                ),
                                SizedBox(
                                  height: Responsive.height(0.5, context),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: AppColors.primaryColor,
                                      size: Responsive.height(2.5, context),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Responsive.height(0.8, context),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextWidget(
                          // FIXME: add Review Details
                          "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  height: 1.7,
                                  fontSize: Responsive.sp(3.4, context),
                                  fontFamily: AppFont.fontMedium,
                                  letterSpacing: 0.3,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.dark),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: () {},
                            child: TextWidget(
                              ConstString.viewreply,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: Responsive.sp(3.5, context),
                                      fontFamily: AppFont.fontFamilysemi,
                                      letterSpacing: 0.2),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Positioned(
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(color: AppColors.white, boxShadow: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 20,
                  offset: Offset(0, -2),
                  spreadRadius: 0,
                ),
              ]),
              height: Responsive.height(9, context),
              width: SizerUtil.width,
              child: Padding(
                padding: const EdgeInsets.only(right: 18,top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(const ReviewScreen());
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.black,
                        fixedSize: Size(Responsive.width(55, context), Responsive.height(7, context)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: TextWidget(
                      ConstString.writereview,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: AppColors.buttontext,
                              letterSpacing: 0.3,
                              fontFamily: AppFont.fontMedium),
                    )),
              ),
            ))
      ],
    ),
  );
}

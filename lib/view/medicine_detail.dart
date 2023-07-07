import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
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
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  MedicineController controller = Get.put(MedicineController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
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
              height: Responsive.height(1.6, context),
            )),
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextWidget(
            "Azithromycin",
            style: TextStyle(
              fontSize: Responsive.sp(3.6, context),
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: const Color(0xFF0D0D0D),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: MedicineWidget(context, tabController, controller),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColors.white, boxShadow: const [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 2,
              offset: Offset(0, 0),
              color: Colors.black12),
        ]),
        height: Responsive.height(10, context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 80),
          child: ElevatedButton(
              onPressed: () {
                Get.to(ReviewScreen());
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: TextWidget(
                ConstString.writereview,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColors.buttontext),
              )),
        ),
      ),
    );
  }
}

Container MedicineWidget(BuildContext context, TabController tabController,
    MedicineController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              height: Responsive.height(15, context),
              decoration: BoxDecoration(
                  boxShadow:  [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: Offset(0, 0),
                        color: AppColors.grey.withOpacity(0.1))
                  ],
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Responsive.width(3, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: Responsive.height(6, context),
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
                            "Azithromycin",
                            style: TextStyle(
                                fontSize: Responsive.sp(3.2, context),
                                fontFamily: AppFont.fontFamilysemi,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5),
                          ),
                          SizedBox(
                            height: Responsive.height(0.5, context),
                          ),
                          TextWidget(
                            "A fast acting antibiotic.\nTackles infections effectively",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: Responsive.sp(2.5, context),
                                fontFamily: AppFont.fontFamily,
                                height: 1.5,
                                color: AppColors.grey),
                          ),
                          SizedBox(
                            height: Responsive.height(1, context),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2, context),
                              ),
                              Icon(
                                Icons.star_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2, context),
                              ),
                              Icon(
                                Icons.star_outline_rounded,
                                color: AppColors.primaryColor,
                                size: Responsive.height(2, context),
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
                                height: Responsive.height(1.5, context),
                              ),
                              SizedBox(
                                width: Responsive.width(1, context),
                              ),
                              TextWidget(
                                ConstString.antibiotic,
                                style: TextStyle(
                                    fontSize: Responsive.sp(2.5, context),
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFont.fontFamily),
                              ),
                              SizedBox(
                                width: Responsive.width(2, context),
                              ),
                              SvgPicture.asset(
                                SvgIcon.Rx,
                                color: AppColors.primaryColor,
                                height: Responsive.height(1.4, context),
                              ),
                              SizedBox(
                                width: Responsive.width(1, context),
                              ),
                              TextWidget(
                                ConstString.prescribed,
                                style: TextStyle(
                                    fontSize: Responsive.sp(2.5, context),
                                    color: AppColors.primaryColor,
                                    fontFamily: AppFont.fontFamily),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.splashdetail),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            SvgIcon.bookmark,
                            height: Responsive.height(2, context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.height(2, context),
          ),
          Container(
            child: TabBar(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              // isScrollable: true,
              // labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              labelColor: AppColors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.tilecolor,
              ),
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.transparent,
              tabs: [
                tabContainer(context, 0, text: "Review"),
                tabContainer(context, 1, text: "Q&A"),
                tabContainer(context, 2, text: "About"),
                tabContainer(context, 3, text: "Warning"),
              ],
            ),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Container(
            width: SizerUtil.width,
            color: AppColors.grey.withOpacity(0.3),
            height: 1,
          ),
          Expanded(
            child: SizedBox(
                height: Responsive.height(60, context),
                child: TabBarView(controller: tabController, children: [
                  ReviewWidget(),
                  QAWidget(context, controller),
                  AboutWidget(context),
                  WarningWidget(context),
                ])),
          )
        ],
      ),
    ),
  );
}

Container WarningWidget(context) {
  return Container(
    height: Responsive.height(30, context),
    margin: EdgeInsets.only(bottom: 180, left: 10, right: 10, top: 10),
    decoration: BoxDecoration(boxShadow:  [
      BoxShadow(
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(0, 0),
          color: AppColors.grey.withOpacity(0.1))
    ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextWidget(
              "Cetirizine, in general, has a low potential for interactions with other drugs. However, certain substances could potentially interact with cetirizine, including",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: Responsive.sp(3, context),
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
                    child: Container(
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
                                fontSize: Responsive.sp(2.8, context)),
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
                    child: Container(
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
                                fontSize: Responsive.sp(2.7, context)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
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
                                fontSize: Responsive.sp(2.7, context)),
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
                    child: Container(
                      height: Responsive.height(9, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(SvgIcon.Rx,
                              height: Responsive.height(2.8, context),color: AppColors.grey,),
                          TextWidget(
                            ConstString.drugs,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                color: AppColors.grey,
                                fontSize: Responsive.sp(2.7, context)),
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
              fontSize: Responsive.sp(2.8, context),
              color: AppColors.orange,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ),
  );
}

Container AboutWidget(context) {
  return Container(
    height: Responsive.height(30, context),
    margin: EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 10),
    decoration: BoxDecoration(boxShadow:  [
      BoxShadow(
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(0, 0),
          color: AppColors.grey.withOpacity(0.1))
    ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextWidget(
              "Cetirizine is an over-the-counter antihistamine used to relieve allergy symptoms such as runny nose, sneezing, itching, watery eyes, and itching of the nose or throat. It also can help relieve itching and swelling caused by chronic urticaria (hives). Cetirizine works by blocking the effects of histamine, a substance in the body that causes allergy symptoms.",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: Responsive.sp(3, context),
                    height: 1.6,
                    color: AppColors.dark,
                  ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: TextWidget(
              "Although Cetirizine is generally considered safe for use, the manufacturers often list several",
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: Responsive.sp(3, context),
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
                "potential warnings and precautions",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: Responsive.sp(3, context),
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
                    child: Container(
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
                                    fontSize: Responsive.sp(2.8, context)),
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
                    child: Container(
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
                                    fontSize: Responsive.sp(2.8, context)),
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
                    child: Container(
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
                                    fontSize: Responsive.sp(2.8, context)),
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
                    child: Container(
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
                                    fontSize: Responsive.sp(2.8, context)),
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
                  fontSize: Responsive.sp(2.8, context),
                  color: AppColors.orange,
                ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ),
  );
}

Container QAWidget(context, MedicineController controller) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: SizerUtil.height,
      decoration: BoxDecoration(boxShadow:  [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(0, 0),
            color: AppColors.grey.withOpacity(0.1))
      ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
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
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    SizedBox(
                      width: Responsive.width(0.5, context),
                    ),
                    SvgPicture.asset(
                      SvgIcon.verify,
                      color: AppColors.sky,
                      height: 12,
                    )
                  ],
                ),
                SizedBox(
                  height: Responsive.height(1.5, context),
                ),
                TextFormField(
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    suffixIcon: SizedBox(
                      height: Responsive.height(3, context),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 10),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 0,
                              backgroundColor: AppColors.primaryColor,
                              fixedSize: const Size(40, 5)),
                          child: Text(
                            ConstString.submit,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: Responsive.sp(2.3, context),
                                    fontFamily: AppFont.fontFamilysemi,
                                    fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Write a question...",
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.whitehome, width: 0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Container(
                  height: 1,
                  color: AppColors.grey.withOpacity(0.1),
                ),
                SizedBox(
                  height: Responsive.height(1.5, context),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      SvgIcon.chat2,
                      height: Responsive.height(2.3, context),
                    ),
                    SizedBox(
                      width: Responsive.width(3, context),
                    ),
                    TextWidget(
                      ConstString.popularquestions,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.blacktxt),
                    ),
                  ],
                ),
                SizedBox(
                  height: Responsive.height(3, context),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.tabSelect == "My Question") {
                            controller.tabSelect.value = "All";
                          }
                          // print(controller.tabSelect);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            alignment: Alignment.center,
                            height: Responsive.height(4.5, context),
                            decoration: BoxDecoration(
                                color: AppColors.tilecolor,
                                // color: controller.tabSelect.value == "All"
                                //     ? AppColors.tilecolor
                                //     : Colors.transparent,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextWidget(
                              "All",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      // color: controller.tabSelect.value == "All"
                                      //     ? AppColors.primaryColor
                                      //     : AppColors.grey,
                                      fontSize: Responsive.sp(3.3, context)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.tabSelect == "All") {
                            controller.tabSelect.value = "My Question";
                          }
                          // print(controller.tabSelect);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            alignment: Alignment.center,
                            height: Responsive.height(4.5, context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: TextWidget(
                              "My Question",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      fontSize: Responsive.sp(3.3, context),
                                      color: AppColors.grey),
                            ),
                          ),
                        ),
                      ),
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
                Container(
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
                                  width: 1,
                                  color: AppColors.lightGrey.withOpacity(0.1))),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            AppColors.grey.withOpacity(0.3),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextWidget(
                                          "John Doe",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  fontSize: Responsive.sp(
                                                      3.4, context),
                                                  fontFamily:
                                                      AppFont.fontFamilysemi,
                                                  fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: Responsive.height(1, context),
                                        ),
                                        TextWidget(
                                          "2 Days Ago",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  // fontSize: Responsive.sp(3.4, context),
                                                  ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    SvgPicture.asset(
                                      SvgIcon.arrowup,
                                      height: Responsive.height(2.2, context),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: TextWidget(
                                        "How much does should my 7 years old son take ?",
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(height: 1.3),
                                      ),
                                    ),
                                    flex: 7,
                                  ),
                                  Expanded(
                                    child: SvgPicture.asset(
                                      SvgIcon.pen,
                                      height: Responsive.height(2, context),
                                    ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: SvgPicture.asset(
                                      SvgIcon.delete,
                                      height: Responsive.height(1.8, context),
                                    ),
                                    flex: 1,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(14, context),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.lightGrey
                                              .withOpacity(0.2)),
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: CircleAvatar(
                                                backgroundColor: AppColors
                                                    .purple
                                                    .withOpacity(0.1),
                                                child: Icon(
                                                  Icons.person,
                                                  color: AppColors.purple
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  Responsive.width(3, context),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    TextWidget(
                                                      "Flores, Juanita",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  Responsive.sp(
                                                                      3,
                                                                      context),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                    ),
                                                    SizedBox(
                                                      width: Responsive.width(
                                                          1, context),
                                                    ),
                                                    SvgPicture.asset(
                                                      SvgIcon.verify,
                                                      color: AppColors.purple,
                                                      height: Responsive.height(
                                                          1.4, context),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Responsive.height(
                                                      1, context),
                                                ),
                                                TextWidget(
                                                  "2 Days Ago",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Responsive.sp(
                                                                  2.4, context),
                                                          color: AppColors.grey
                                                              .withOpacity(
                                                                  0.5)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 10),
                                          child: TextWidget(
                                            "Yes, that is completely fine, make sure to take right dosages.",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: Responsive.sp(
                                                        2.7, context),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(14, context),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: AppColors.lightGrey
                                              .withOpacity(0.2)),
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: CircleAvatar(
                                                backgroundColor: AppColors
                                                    .purple
                                                    .withOpacity(0.1),
                                                child: Icon(
                                                  Icons.person,
                                                  color: AppColors.purple
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  Responsive.width(3, context),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    TextWidget(
                                                      "Cooper, Kristin",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge!
                                                          .copyWith(
                                                              fontSize:
                                                                  Responsive.sp(
                                                                      3,
                                                                      context),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800),
                                                    ),
                                                    SizedBox(
                                                      width: Responsive.width(
                                                          1, context),
                                                    ),
                                                    SvgPicture.asset(
                                                      SvgIcon.verify,
                                                      color: AppColors.purple,
                                                      height: Responsive.height(
                                                          1.4, context),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Responsive.height(
                                                      1, context),
                                                ),
                                                TextWidget(
                                                  "2 Days Ago",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall!
                                                      .copyWith(
                                                          fontSize:
                                                              Responsive.sp(
                                                                  2.4, context),
                                                          color: AppColors.grey
                                                              .withOpacity(
                                                                  0.5)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 10),
                                          child: TextWidget(
                                            "Yes, that is completely fine, make sure to take right dosages.",
                                            textAlign: TextAlign.start,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: Responsive.sp(
                                                        2.7, context),
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
                )
              ]),
        ),
      ),
    ),
  ));
}

Container ReviewWidget() {
  return Container(
    child: ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Responsive.height(48, context),
            decoration: BoxDecoration(boxShadow:  [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                  color: AppColors.grey.withOpacity(0.1))
            ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(ConstString.mostrecent,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.grey)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.primaryColor,
                            size: Responsive.height(2.5, context),
                          ),
                          TextWidget(
                            "3.9/5",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: Responsive.sp(3.8, context)),
                          )
                        ],
                      )
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
                    height: Responsive.height(1.5, context),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 20,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              "John Doe",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFont.fontFamilysemi,
                                      fontSize: Responsive.sp(3.5, context)),
                            ),
                            SizedBox(
                              height: Responsive.height(0.5, context),
                            ),
                            TextWidget(
                              "Closest Match • Caucasian Male, 61",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(2.3, context)),
                            ),
                            SizedBox(
                              height: Responsive.height(0.5, context),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_outline_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Responsive.height(1, context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextWidget(
                      "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          height: 1.5,
                          fontSize: Responsive.sp(2.6, context),
                          color: AppColors.grey),
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
                              .copyWith(fontSize: Responsive.sp(2.5, context)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: 20,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              "John Doe",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: AppFont.fontFamilysemi,
                                      fontSize: Responsive.sp(3.5, context)),
                            ),
                            SizedBox(
                              height: Responsive.height(0.5, context),
                            ),
                            TextWidget(
                              "Closest Match • Caucasian Male, 61",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(2.3, context)),
                            ),
                            SizedBox(
                              height: Responsive.height(0.5, context),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                                Icon(
                                  Icons.star_outline_rounded,
                                  color: AppColors.primaryColor,
                                  size: Responsive.height(2, context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Responsive.height(1, context),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextWidget(
                      "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          height: 1.5,
                          fontSize: Responsive.sp(2.6, context),
                          color: AppColors.grey),
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
                              .copyWith(fontSize: Responsive.sp(2.5, context)),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

List tabList = ["Review", "Q&A", "About", "Warning"];

Widget tabContainer(context, index, {required String text}) {
  return SizedBox(
    height: Responsive.height(4, context),
    // width: Responsive.width(25, context),
    child: Tab(
      child: Container(
        decoration: BoxDecoration(
          // color: tabList[index] == index ? AppColors.primaryColor : AppColors.grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Align(
          child: Text(text,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: tabList[index] == index
                      ? AppColors.primaryColor
                      : AppColors.grey,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppFont.fontFamilysemi)),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
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
      body: MedicineWidget(context, tabController),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColors.white, boxShadow: const [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 2,
              offset: Offset(0, 0),
              color: Colors.black12),
        ]),
        height: Responsive.height(10, context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 80),
          child: ElevatedButton(
              onPressed: () {},
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

Container MedicineWidget(BuildContext context, TabController tabController) {
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
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(1, 1),
                        color: Colors.black12)
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
                  QAWidget(context),
                  const Center(child: Text("Tab3")),
                  const Center(child: Text("Tab4")),
                ])),
          )
        ],
      ),
    ),
  );
}

Container QAWidget(context) {
  return Container(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: Responsive.height(100, context),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
            offset: Offset(1, 1),
            color: Colors.black12)
      ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(physics: const ScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(SvgIcon.expert),
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
                    fillColor: AppColors.searchbar.withOpacity(0.7),
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: Responsive.height(4.5, context),
                          decoration: BoxDecoration(
                              color: AppColors.tilecolor,
                              borderRadius: BorderRadius.circular(30)),
                          child: TextWidget(
                            "All",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: Responsive.sp(3.3, context)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
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
                  height: SizerUtil.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Responsive.height(10, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          child: ExpansionTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.grey.withOpacity(0.3),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ),
                              title: Align(
                                alignment: Alignment.topLeft,
                                child: TextWidget(
                                  "John Doe",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          fontSize: Responsive.sp(3.4, context),
                                          fontFamily: AppFont.fontFamilysemi,
                                          fontWeight: FontWeight.w800),
                                ),
                              ),
                              subtitle: Align(
                                alignment: Alignment.topLeft,
                                child: TextWidget(
                                  "2 Days Ago",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                          // fontSize: Responsive.sp(3.4, context),
                                          ),
                                ),
                              )),
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
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                  color: Colors.black12)
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

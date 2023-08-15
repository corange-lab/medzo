import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/review.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/review_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MedicineDetail extends StatefulWidget {
  final List<Medicine>? medicineDetails;
  final int? index;

  MedicineDetail({this.medicineDetails, this.index});

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail>
    with TickerProviderStateMixin {
  late TabController tabController;

  HomeController homeController = Get.put(HomeController());
  MedicineController medicineController = Get.put(MedicineController());

  List<Medicine>? medicineDetails;
  int? index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

    medicineDetails = widget.medicineDetails;
    index = widget.index;
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
              height: 15,
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextWidget(
              // FIXME: add Medicine Name
              "${medicineDetails![index!].medicineName}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 17.5,
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: medicineWidget(context, tabController, medicineController,
          homeController, medicineDetails!, index!),
    );
  }
}

Container medicineWidget(
    BuildContext context,
    TabController tabController,
    MedicineController medicineController,
    HomeController homeController,
    List<Medicine> medicineDetails,
    int index) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.splashdetail),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SizedBox(
                            height: 55,
                            width: 55,
                            child: SvgPicture.asset(AppImages.supplements),
                            // child: ClipRRect(
                            //   borderRadius: BorderRadius.circular(7),
                            //   child: CachedNetworkImage(
                            //     imageUrl: medicineDetails[index].image!,
                            //     errorWidget: (context, url, error) =>
                            //         Icon(Icons.error),
                            //     progressIndicatorBuilder:
                            //         (context, url, downloadProgress) =>
                            //             SizedBox(
                            //       width: 120,
                            //       child: Center(
                            //         child: CupertinoActivityIndicator(
                            //           color: AppColors.primaryColor,
                            //           animating: true,
                            //           radius: 12,
                            //         ),
                            //       ),
                            //     ),
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                "${medicineDetails[index].medicineName}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: 14.5,
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontBold,
                                        letterSpacing: 0),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              SizedBox(
                                width: 160,
                                height: 35,
                                child: TextWidget(
                                  "${medicineDetails[index].shortDescription}",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          height: 1.5,
                                          color: AppColors.grey,
                                          fontFamily: AppFont.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  SvgIcon.fillbookmark,
                                  height: 15,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 83),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SmoothStarRating(
                          rating: 4,
                          allowHalfRating: true,
                          defaultIconData: Icons.star_outline_rounded,
                          filledIconData: Icons.star_rounded,
                          halfFilledIconData: Icons.star_half_rounded,
                          starCount: 5,
                          size: 20,
                          color: AppColors.primaryColor,
                          borderColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 85),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pill,
                              color: AppColors.primaryColor,
                              height: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextWidget(
                              "${medicineDetails[index].genericName!.length > 20 ? "${medicineDetails[index].genericName!.substring(0, 20)}..." : medicineDetails[index].genericName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                color: AppColors.primaryColor,
                                fontFamily:
                                AppFont.fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            // SvgPicture.asset(
                            //   SvgIcon.Rx,
                            //   color: AppColors.primaryColor,
                            //   height: 14,
                            // ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            // TextWidget(
                            //   ConstString.prescribed,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .titleSmall!
                            //       .copyWith(
                            //         color: AppColors.primaryColor,
                            //         fontWeight: FontWeight.w500,
                            //         letterSpacing: 0.2,
                            //         fontSize: 12,
                            //       ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TabBar(
            labelPadding: EdgeInsets.all(3),
            controller: tabController,
            physics: const BouncingScrollPhysics(),
            labelColor: AppColors.primaryColor,
            labelStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontFamily: AppFont.fontFamily),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(
                    fontSize: 12.5,
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
                height: 30,
              ),
              // Tab(
              //   text: "Q&A",
              //   height: 30,
              // ),
              Tab(
                text: "About",
                height: 30,
              ),
              Tab(
                text: "Warning",
                height: 30,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: SizerUtil.width,
            color: AppColors.grey.withOpacity(0.3),
            height: 0.5,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: SizedBox(
                height: 450,
                child: TabBarView(controller: tabController, children: [
                  reviewWidget(context, medicineController,
                      medicineDetails as List<Medicine>, index),
                  // questionWidget(context, tabQuestionController),
                  aboutWidget(context),
                  warningWidget(context, medicineDetails, index),
                ])),
          )
        ],
      ),
    ),
  );
}

Container warningWidget(context, List<Medicine> medicineDetails, index) {
  return Container(
    // height: Responsive.height(10, context),
    margin: EdgeInsets.only(
        bottom: medicineDetails[index].warning!.length > 300
            ? 20
            : (medicineDetails[index].warning!.length > 100 ? 200 : 260),
        left: 10,
        right: 10,
        top: 10),
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.splashdetail),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextWidget(
                // FIXME: add Medicine warning
                "${medicineDetails[index].warning}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 13.2,
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.alcohol,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.alcohol,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pill,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.maoi,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.snowflack,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.therphy,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 10.9),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.Rx,
                              height: 25,
                              color: AppColors.grey,
                            ),
                            TextWidget(
                              ConstString.drugs,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                    fontSize: 13.2,
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

Container aboutWidget(context) {
  return Container(
    // height: 440,
    margin: const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 10),
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
                      fontSize: 13.2,
                      fontWeight: FontWeight.w400,
                      fontFamily: AppFont.fontMedium,
                      height: 1.6,
                      color: AppColors.dark,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextWidget(
                // FIXME: add Medicine details
                "Although Cetirizine is generally considered safe for use, the manufacturers often list several",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 13.2,
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
                        fontSize: 13.2,
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pass_eye,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.drowsiness,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.baby,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.pregnancy,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.pill,
                              height: 25,
                            ),
                            TextWidget(
                              ConstString.allergy,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(SvgIcon.masksad, height: 25),
                            TextWidget(
                              ConstString.olderage,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.grey, fontSize: 11.5),
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
              height: 5,
            ),
            TextWidget(
              ConstString.clickicon,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    height: 1.5,
                    fontSize: 13,
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

Container reviewWidget(
    context, medicineController, List<Medicine> medicineDetails, int index) {
  return Container(
    child: Stack(
      children: [
        StreamBuilder<List<Review>>(
            stream: medicineController.getReview(medicineDetails[index].id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          // Replace this with your Shimmer placeholder widgets
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(),
                                    trailing:
                                        SvgPicture.asset(SvgIcon.fillbookmark),
                                    title: Text("MEDZO"),
                                  ),
                                ),
                                Container(
                                  height: 12.h,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.whitehome),
                                )
                              ],
                            ),
                            margin: EdgeInsets.all(3),
                          ),
                          Divider(
                            height: 3,
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
              List<Review>? reviewList = snapshot.data!;
              List<double> ratingList = [];

              if (snapshot.hasData && reviewList.isNotEmpty) {
                for (var i = 0; i < reviewList.length; i++) {
                  ratingList.add(reviewList[i].rating!);
                }

                String medicineRating =
                    medicineController.findMedicineRating(ratingList);

                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.splashdetail),
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
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
                                              fontSize: 13,
                                              letterSpacing: 0.3)),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  SvgPicture.asset(
                                    SvgIcon.arrowdown,
                                    height: 15,
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryColor,
                                    size: 23,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: TextWidget(
                                      "${medicineRating ?? "0"}/5",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(
                                              fontSize: 16,
                                              fontFamily:
                                                  AppFont.fontFamilysemi),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: SizedBox(
                          height: SizerUtil.height,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: reviewList.length,
                            itemBuilder: (context, index) {
                              UserModel user = medicineController
                                  .findUser(reviewList[index].userId);
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    reviewHeaderWidget(
                                        context, user, reviewList, index),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: TextWidget(
                                          "${reviewList[index].review}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  height: 1.7,
                                                  fontSize: 12.5,
                                                  fontFamily:
                                                      AppFont.fontMedium,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.dark),
                                          textAlign: TextAlign.start,
                                        ),
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
                                                    fontSize: 12.5,
                                                    fontFamily:
                                                        AppFont.fontFamilysemi,
                                                    letterSpacing: 0.2),
                                          )),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 300,
                                      color: AppColors.grey.withOpacity(0.1),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                );
              } else {
                return Container(
                  color: AppColors.white,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Image.asset(
                            SvgIcon.nodata,
                            scale: 0.5,
                          ),
                          width: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ConstString.noReview,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontFamily: AppFont.fontBold),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
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
              height: 70,
              width: SizerUtil.width,
              child: Padding(
                padding: const EdgeInsets.only(right: 18, top: 10),
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(ReviewScreen(medicineDetails, index));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.black,
                        fixedSize: Size(190, 55),
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

ListTile reviewHeaderWidget(
    BuildContext context, UserModel user, reviewList, index) {
  return ListTile(
    leading: OtherProfilePicWidget(
      profilePictureUrl: user.profilePicture,
      size: Size(45, 45),
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        TextWidget(
          "${user.name}",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(fontFamily: AppFont.fontBold, fontSize: 14),
        ),
        SizedBox(
          height: 5,
        ),
        TextWidget(
          "${user.profession ?? "-"}",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.grey,
              fontFamily: AppFont.fontMedium,
              fontWeight: FontWeight.w500,
              fontSize: 11),
        ),
        SizedBox(
          height: 5,
        ),
        SmoothStarRating(
          rating: reviewList[index].rating!,
          allowHalfRating: true,
          defaultIconData: Icons.star_outline_rounded,
          filledIconData: Icons.star_rounded,
          halfFilledIconData: Icons.star_half_rounded,
          starCount: 5,
          size: 20,
          color: AppColors.primaryColor,
          borderColor: AppColors.primaryColor,
        ),
      ],
    ),
  );
}

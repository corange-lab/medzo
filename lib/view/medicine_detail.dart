import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/model/review_data_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/review_reply_screen.dart';
import 'package:medzo/view/review_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_shimmer_widget.dart';
import 'package:medzo/widgets/medicine_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MedicineDetail extends StatefulWidget {
  final Medicine? medicineDetail;

  MedicineDetail({this.medicineDetail});

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail>
    with TickerProviderStateMixin {
  late TabController tabController;

  HomeController homeController = Get.put(HomeController());
  MedicineController medicineController = Get.put(MedicineController());

  Medicine? medicineDetail;

  @override
  void initState() {
    medicineDetail = widget.medicineDetail;
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
              medicineDetail?.genericName ?? '-',
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
          homeController, medicineDetail),
    );
  }

  Container medicineWidget(
      BuildContext context,
      TabController tabController,
      MedicineController medicineController,
      HomeController homeController,
      Medicine? medicineDetails) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            //   child: Container(
            //     height: 140,
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 1, color: AppColors.splashdetail),
            //         color: AppColors.white,
            //         borderRadius: BorderRadius.circular(8)),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 14),
            //       child: Column(
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(right: 8),
            //                 child: SizedBox(
            //                   height: 45,
            //                   width: 45,
            //                   child: SvgPicture.asset(AppImages.supplements),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 8),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     TextWidget(
            //                       medicineDetails?.medicineName ?? '-',
            //                       style: Theme.of(context)
            //                           .textTheme
            //                           .labelSmall!
            //                           .copyWith(
            //                               fontSize: 14.5,
            //                               color: AppColors.darkPrimaryColor,
            //                               fontFamily: AppFont.fontBold,
            //                               letterSpacing: 0),
            //                     ),
            //                     SizedBox(
            //                       height: 3,
            //                     ),
            //                     SizedBox(
            //                       width: 160,
            //                       height: 35,
            //                       child: TextWidget(
            //                         "${medicineDetails?.shortDescription ?? '--'}",
            //                         textAlign: TextAlign.start,
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .titleSmall!
            //                             .copyWith(
            //                                 height: 1.5,
            //                                 color: AppColors.grey,
            //                                 fontFamily: AppFont.fontFamily,
            //                                 fontWeight: FontWeight.w400,
            //                                 fontSize: 11.5),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               const Spacer(),
            //               GestureDetector(
            //                 onTap: () {},
            //                 child: Padding(
            //                   padding: EdgeInsets.symmetric(horizontal: 6),
            //                   child: Container(
            //                     height: 38,
            //                     width: 38,
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(20),
            //                         color: AppColors.splashdetail),
            //                     child: Padding(
            //                       padding: EdgeInsets.all(10),
            //                       child: SvgPicture.asset(
            //                         SvgIcon.fillbookmark,
            //                         height: 15,
            //                         color: AppColors.primaryColor,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 5,
            //               )
            //             ],
            //           ),
            //           SizedBox(
            //             height: 3,
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 83),
            //             child: Align(
            //               alignment: Alignment.centerLeft,
            //               child: SmoothStarRating(
            //                 rating: 4,
            //                 allowHalfRating: true,
            //                 defaultIconData: Icons.star_outline_rounded,
            //                 filledIconData: Icons.star_rounded,
            //                 halfFilledIconData: Icons.star_half_rounded,
            //                 starCount: 5,
            //                 size: 20,
            //                 color: AppColors.primaryColor,
            //                 borderColor: AppColors.primaryColor,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Padding(
            //             padding: EdgeInsets.only(left: 85),
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   SvgPicture.asset(
            //                     SvgIcon.pill,
            //                     color: AppColors.primaryColor,
            //                     height: 14,
            //                   ),
            //                   SizedBox(
            //                     width: 5,
            //                   ),
            //                   TextWidget(
            //                     medicineDetails?.genericName ?? '-',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .titleSmall!
            //                         .copyWith(
            //                           color: AppColors.primaryColor,
            //                           fontFamily: AppFont.fontFamily,
            //                           fontWeight: FontWeight.w500,
            //                           letterSpacing: 0.2,
            //                           fontSize: 12,
            //                         ),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            MedicineWidget(
                medicineDetail: medicineDetail!,
                medicineBindPlace: MedicineBindPlace.dashboard),
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
                    reviewWidget(context, medicineController, medicineDetails!),
                    aboutWidget(context),
                    warningWidget(context, medicineDetails),
                  ])),
            )
          ],
        ),
      ),
    );
  }

  Container warningWidget(context, Medicine medicineDetails) {
    return Container(
      // height: Responsive.height(10, context),
      // margin: EdgeInsets.only(
      //     bottom: medicineDetails.warning!.length > 300
      //         ? 20
      //         : (medicineDetails.warning!.length > 100 ? 200 : 260),
      //     left: 10,
      //     right: 10,
      //     top: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.splashdetail),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6)),
      child: medicineDetail!.warnings != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: TextWidget(
                        medicineDetails.warnings!,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: 14,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 10.9),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(
                                      SvgIcon.Rx,
                                      height: 25,
                                      colorFilter: ColorFilter.mode(
                                          AppColors.grey2, BlendMode.srcIn),
                                    ),
                                    TextWidget(
                                      ConstString.drugs,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color: AppColors.grey,
                                              fontSize: 11.5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: TextWidget(
                        ConstString.clickicon,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  height: 1.5,
                                  fontFamily: AppFont.fontFamilysemi,
                                  fontSize: 13.2,
                                  color: AppColors.red,
                                ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
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
                    ConstString.noWarning,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ),
            ),
    );
  }

  Container aboutWidget(context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 40, left: 10, right: 10, top: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.splashdetail),
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6)),
      child: medicineDetail!.shortDescription!.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: TextWidget(
                        "${medicineDetail!.shortDescription}",
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SvgPicture.asset(SvgIcon.masksad,
                                        height: 25),
                                    TextWidget(
                                      ConstString.olderage,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              color: AppColors.grey,
                                              fontSize: 11.5),
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
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                height: 1.5,
                                fontSize: 13,
                                fontFamily: AppFont.fontFamilysemi,
                                color: AppColors.red,
                              ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          : Center(
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
                    ConstString.noAbout,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ),
            ),
    );
  }

  Container reviewWidget(BuildContext context,
      MedicineController medicineController, Medicine medicineDetails) {
    List<ReviewDataModel>? reviewList;
    return Container(
      child: Stack(
        children: [
          StreamBuilder<List<ReviewDataModel>>(
              stream: medicineController.getReview(medicineDetails.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return MedicineShimmerWidget();
                }
                reviewList = snapshot.data!;

                if (snapshot.hasData && reviewList!.isNotEmpty) {
                  String medicineRating =
                      medicineController.countMedicineRating(reviewList!);

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
                                      padding: const EdgeInsets.only(top: 3),
                                      child: TextWidget(
                                        "${medicineRating}/5",
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
                              itemCount: reviewList!.length,
                              itemBuilder: (context, index) {
                                ReviewDataModel review = reviewList![index];
                                UserModel user =
                                    medicineController.findUser(review.userId!);
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: reviewHeaderWidget(context,
                                                user, reviewList, index),
                                          ),
                                          _getTrailingIcon(
                                              reviewList!.elementAt(index),
                                              medicineController,
                                              context)
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: TextWidget(
                                            "${review.review}",
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
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: TextButton(
                                                onPressed: () async {
                                                  print(
                                                      "For : ${review.reviewReplies?.length}");
                                                  medicineController
                                                          .currentReviewData =
                                                      review;
                                                  var result = await Get.to(
                                                      () => ReviewReplyScreen(
                                                          user, review));
                                                  if (result == 'Deleted') {
                                                    reviewList!.removeAt(index);
                                                    medicineController.update();
                                                  }
                                                },
                                                child: TextWidget(
                                                  ConstString.viewreply,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium!
                                                      .copyWith(
                                                          fontSize: 12.5,
                                                          fontFamily: AppFont
                                                              .fontFamilysemi,
                                                          letterSpacing: 0.2),
                                                )),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                medicineController.addUpvote(
                                                    review,
                                                    isForUpvote: true);
                                              },
                                              icon: Icon(
                                                Icons.plus_one,
                                                color: medicineController
                                                        .isVoted(review,
                                                            forUpvote: true)
                                                    ? Colors.red
                                                    : Colors.black,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                medicineController.addUpvote(
                                                    review,
                                                    isForUpvote: false);
                                              },
                                              icon: Icon(
                                                Icons.exposure_minus_1,
                                                color: medicineController
                                                        .isVoted(review,
                                                            forUpvote: false)
                                                    ? Colors.red
                                                    : Colors.black,
                                              )),
                                        ],
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
                  padding:
                      const EdgeInsets.only(right: 18, top: 10, bottom: 10),
                  child: ElevatedButton(
                      onPressed: () async {
                        await Get.to(
                            () => ReviewScreen(medicineDetails, reviewList));
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

  Widget _getTrailingIcon(
    ReviewDataModel reviewData,
    MedicineController medicineController,
    BuildContext context,
  ) {
    if (reviewData.userId != medicineController.loggedInUserId) {
      return SizedBox();
    }
    return GestureDetector(
        onTap: () async {
          await _deleteReviewDialog(context, reviewData);
        },
        child: Icon(
          Icons.delete_outlined,
          color: AppColors.notificationOff,
        ));
  }

  Future<void> _deleteReviewDialog(
      BuildContext context, ReviewDataModel reviewData) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TextWidget(
            ConstString.deleteReview,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 19,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
          content: TextWidget(
            ConstString.deleteReviewMessage,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontFamily: AppFont.fontMedium,
                height: 1.3,
                letterSpacing: 0,
                color: AppColors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: TextWidget(
                ConstString.cancel,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontFamily: AppFont.fontFamilysemi,
                    letterSpacing: 0,
                    color: AppColors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                await medicineController.deleteReview(reviewData);
                Get.back();
              },
              child: TextWidget(
                ConstString.delete,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontFamily: AppFont.fontFamilysemi,
                    letterSpacing: 0,
                    color: AppColors.notificationOff),
              ),
            ),
          ],
        );
      },
    );
  }
}

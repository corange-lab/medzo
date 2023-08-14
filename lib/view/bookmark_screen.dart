// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class BookmarkScreen extends StatelessWidget {
  MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: TextWidget(
              ConstString.bookmark,
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
      body: StreamBuilder<List<Medicine>>(
        stream: medicineController.fetchMedicine(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 4,
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
          if (snapshot.hasData) {
            List<Medicine> medicineDetails = snapshot.data!;

            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(Duration(seconds: 2));
                  },
                  color: AppColors.primaryColor,
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: medicineDetails.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: Container(
                            height: 175,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: AppColors.splashdetail),
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: SizedBox(
                                            height: 55,
                                            width: 55,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: CachedNetworkImage(
                                                imageUrl: medicineDetails[index]
                                                    .image!,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child:
                                                        CupertinoActivityIndicator(
                                                      color: AppColors
                                                          .primaryColor,
                                                      animating: true,
                                                      radius: 12,
                                                    ),
                                                  ),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextWidget(
                                              "${medicineDetails[index].medicineName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      fontSize: 14.5,
                                                      color: AppColors
                                                          .darkPrimaryColor,
                                                      fontFamily:
                                                          AppFont.fontBold,
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
                                                        fontFamily:
                                                            AppFont.fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Container(
                                            height: 38,
                                            width: 38,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.splashdetail),
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: SvgPicture.asset(
                                                SvgIcon.fillbookmark,
                                                height: 20,
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
                                        defaultIconData:
                                            Icons.star_outline_rounded,
                                        filledIconData: Icons.star_rounded,
                                        halfFilledIconData:
                                            Icons.star_half_rounded,
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
                                    padding: EdgeInsets.only(
                                        left: medicineDetails[index]
                                                    .drugType!
                                                    .length >=
                                                16
                                            ? 45
                                            : 5),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            "${medicineDetails[index].drugType}",
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
                                          SvgPicture.asset(
                                            SvgIcon.Rx,
                                            color: AppColors.primaryColor,
                                            height: 14,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          TextWidget(
                                            ConstString.prescribed,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: AppColors.primaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.2,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Get.to(MedicineDetail(
                                            medicineDetails: medicineDetails,
                                            index: index,
                                          ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: AppColors
                                                .splashdetail
                                                .withOpacity(0.7),
                                            fixedSize: Size(160, 0),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 0.5,
                                                    color: AppColors.grey
                                                        .withOpacity(0.1)),
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextWidget(
                                              ConstString.viewmoredetails,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      fontSize: 11,
                                                      color: AppColors.dark,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          AppFont.fontMedium),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 15,
                                              color: AppColors.dark,
                                            )
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ));
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                      SvgIcon.nodata,
                      scale: 0.5,
                    ),
                    width: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ConstString.noMedicine,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 18,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

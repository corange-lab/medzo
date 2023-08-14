// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class CategoryWiseMedicine extends StatelessWidget {
  List<Category_Model>? categoryList;
  int index;

  CategoryWiseMedicine(this.categoryList, this.index);

  MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
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
          child: TextWidget(
            "${categoryList![index].name}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 17.5,
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: StreamBuilder(
        stream: medicineController
            .getCategoryWiseMedicine(categoryList![index].id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data?.length != 0) {
            List<Medicine>? medicineList = snapshot.data;
            return ListView.builder(
              itemCount: medicineList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.splashdetail),
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: CachedNetworkImage(
                                      imageUrl: medicineList[index].image!,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: CupertinoActivityIndicator(
                                            color: AppColors.primaryColor,
                                            animating: true,
                                            radius: 12,
                                          ),
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      // FIXME: add Medicine Name
                                      "${medicineList[index].medicineName}",
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
                                        "${medicineList[index].shortDescription}",
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
                            padding:  EdgeInsets.only(left: medicineList[index]
                                .drugType!
                                .length >=
                                16
                                ? 45
                                : 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                  "${medicineList[index].drugType}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: AppColors.primaryColor,
                                        fontFamily: AppFont.fontFamily,
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
                                  // FIXME: add Medicine Type
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container(
              child: Center(
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
              ),
            );
          }
        },
      ),
    );
  }
}

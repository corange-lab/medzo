
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                // onTap: () {
                //   Get.to(const MedicineDetail());
                // },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Container(
                    height: 175,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColors.splashdetail),
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
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
                              child: Image.asset(AppImages.pill),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWidget(
                                  // FIXME: add Medicine Name
                                  "Azithromycin",
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
                                TextWidget(
                                  // FIXME: add Medicine Details
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
                                          fontSize: 11.5),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star_rounded,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: AppColors.primaryColor,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(const MedicineDetail());
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
                                                    fontWeight: FontWeight.w500,
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
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
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
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}

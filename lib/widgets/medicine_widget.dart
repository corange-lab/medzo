import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class MedicineWidget extends StatelessWidget {
  final Medicine medicineDetail;
  final MedicineBindPlace medicineBindPlace;

  const MedicineWidget({
    super.key,
    required this.medicineDetail,
    required this.medicineBindPlace,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicineController>(
        id: medicineDetail.id.toString(),
        builder: (ctrl) {
          double rating = double.parse(medicineDetail.ratings ?? "0.0");

          return GestureDetector(
            onTap: () {
              Get.to(MedicineDetail(medicineDetail: medicineDetail));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.splashdetail),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
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
                                height: 45,
                                width: 45,
                                child: SvgPicture.asset(AppImages.supplements)),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    medicineDetail.brandName ?? "",
                                    textAlign: TextAlign.start,
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
                                    "${(medicineDetail.shortDescription!.length > 70 ? "${medicineDetail.shortDescription!.substring(0, 70)}..." : medicineDetail.shortDescription) ?? "Medicine Description"}",
                                    textAlign: TextAlign.start,
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLine: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            height: 1.5,
                                            color: AppColors.grey,
                                            fontFamily: AppFont.fontFamily,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.5),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.splashdetail),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    ctrl.isFavourite(medicineDetail.id)
                                        ? 3
                                        : 0),
                                child: GetBuilder<MedicineController>(
                                    id: medicineDetail.id! + 'update',
                                    builder: (ctrl) {
                                      return IconButton(
                                        onPressed: () async {
                                          await ctrl.addFavouriteMedicine(
                                              medicineDetail.id!);
                                        },
                                        icon: (ctrl.updatingId ==
                                                medicineDetail.id)
                                            ? SizedBox(
                                                width: 30,
                                                child: Center(
                                                  child:
                                                      CupertinoActivityIndicator(
                                                    color:
                                                        AppColors.primaryColor,
                                                    animating: true,
                                                    radius: 8,
                                                  ),
                                                ),
                                              )
                                            : SvgPicture.asset(
                                                ctrl.isFavourite(
                                                        medicineDetail.id)
                                                    ? SvgIcon.fillbookmark
                                                    : SvgIcon.bookmark,
                                                height: 20,
                                                color: ctrl.isFavourite(
                                                        medicineDetail.id)
                                                    ? AppColors.primaryColor
                                                    : Colors.black,
                                              ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.width(1, context),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      rating != 0.0
                          ? Padding(
                              padding: EdgeInsets.only(left: 75),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SmoothStarRating(
                                  rating: rating,
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
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 75),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                SvgIcon.pill,
                                color: AppColors.primaryColor,
                                height: 14,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 200,
                                child: TextWidget(
                                  "${medicineDetail.genericName}",
                                  maxLine: 2,
                                  textAlign: TextAlign.start,
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
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

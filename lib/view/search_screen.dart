import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_shimmer_widget.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    bool isShow = false;

    return GetBuilder<MedicineController>(
      init: MedicineController(),
      builder: (controller) {
        isShow = true;
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
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: 45,
                  child: TextFormField(
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    controller: controller.searchMedicineText,
                    cursorColor: AppColors.grey,
                    onChanged: (value) {
                      controller.searchMedicineByName(value);
                      if (controller.searchMedicineText.text.isNotEmpty) {
                        isShow = true;
                      } else {
                        isShow = false;
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      filled: true,
                      enabled: true,
                      suffixIcon: isShow
                          ? Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: IconButton(
                                onPressed: () {
                                  controller.searchMedicineText.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 22,
                                ),
                              ),
                            )
                          : SizedBox(),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 10),
                        child: SvgPicture.asset(
                          SvgIcon.search,
                          height: 15,
                        ),
                      ),
                      fillColor: AppColors.splashdetail,
                      hintText: "Search here",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 14),
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
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            elevation: 3,
            shadowColor: AppColors.splashdetail.withOpacity(0.1),
          ),
          body: Obx(() {
            if (controller.medicines.isNotEmpty &&
                controller.searchMedicineText.text.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: ListView.builder(
                  itemCount: controller.medicines.length,
                  itemBuilder: (context, index) {
                    final medicine = controller.medicines[index];
                    double rating = double.parse(medicine.ratings ?? "0.0");

                    return FutureBuilder(
                      future:
                          controller.fetchCategoryFromId(medicine.categoryId!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: MedicineShimmerWidget(
                              height: 150,
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          CategoryDataModel category = snapshot.data!;

                          return GestureDetector(
                            onTap: () async {
                              await Get.to(() =>
                                  MedicineDetail(medicineDetail: medicine));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: AppColors.splashdetail),
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                height: 45,
                                                width: 45,
                                                child: SvgPicture.network(
                                                    category.image!)),
                                          ),
                                          SizedBox(width: 5),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextWidget(
                                                    medicine.brandName ?? "",
                                                    textAlign: TextAlign.start,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontSize: 14.5,
                                                            color: AppColors
                                                                .darkPrimaryColor,
                                                            fontFamily: AppFont
                                                                .fontBold,
                                                            letterSpacing: 0),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  TextWidget(
                                                    "${medicine.shortDescription!.length > 70 ? "${medicine.shortDescription!.substring(0, 70)}..." : medicine.shortDescription}",
                                                    textAlign: TextAlign.start,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    maxLine: 2,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            height: 1.5,
                                                            color:
                                                                AppColors.grey,
                                                            fontFamily: AppFont
                                                                .fontFamily,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12.5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Container(
                                              height: 38,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      AppColors.splashdetail),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    controller.isFavourite(
                                                            medicine.id)
                                                        ? 3
                                                        : 0),
                                                child:
                                                    GetBuilder<
                                                            MedicineController>(
                                                        id: medicine.id! +
                                                            'update',
                                                        builder: (ctrl) {
                                                          return IconButton(
                                                            onPressed:
                                                                () async {
                                                              await ctrl
                                                                  .addFavouriteMedicine(
                                                                      medicine
                                                                          .id!);
                                                            },
                                                            icon:
                                                                (ctrl.updatingId ==
                                                                        medicine
                                                                            .id)
                                                                    ? SizedBox(
                                                                        width:
                                                                            30,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              CupertinoActivityIndicator(
                                                                            color:
                                                                                AppColors.primaryColor,
                                                                            animating:
                                                                                true,
                                                                            radius:
                                                                                8,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : SvgPicture
                                                                        .asset(
                                                                        ctrl.isFavourite(medicine.id)
                                                                            ? SvgIcon.fillbookmark
                                                                            : SvgIcon.bookmark,
                                                                        height:
                                                                            18,
                                                                        // ignore: deprecated_member_use
                                                                        color: ctrl.isFavourite(medicine.id)
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
                                      rating == "0.0"
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(left: 75),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SmoothStarRating(
                                                  rating: rating,
                                                  allowHalfRating: true,
                                                  defaultIconData: Icons
                                                      .star_outline_rounded,
                                                  filledIconData:
                                                      Icons.star_rounded,
                                                  halfFilledIconData:
                                                      Icons.star_half_rounded,
                                                  starCount: 5,
                                                  size: 20,
                                                  color: AppColors.primaryColor,
                                                  borderColor:
                                                      AppColors.primaryColor,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SvgPicture.asset(
                                                SvgIcon.pill,
                                                // ignore: deprecated_member_use
                                                color: AppColors.primaryColor,
                                                height: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              TextWidget(
                                                "${medicine.genericName ?? ""}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily:
                                                          AppFont.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.2,
                                                      fontSize: 12,
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
                        } else {
                          return Center(
                            child: MedicineShimmerWidget(
                              height: 150,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              );
            } else {
              if (controller.searchMedicineText.text.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          SvgIcon.nodata,
                          scale: 0.5,
                        ),
                        width: 70,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ConstString.noMedicine,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: 20,
                            fontFamily: AppFont.fontBold),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.doc_text_search,
                          color: AppColors.primaryColor, size: 50),
                      SizedBox(height: 15),
                      Text(
                        "Search Medicine",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 22,
                                fontFamily: AppFont.fontFamilysemi,
                                color: AppColors.black),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
        );
      },
    );
  }
}

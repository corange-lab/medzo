import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/medicine_detail.dart';
import 'package:medzo/widgets/custom_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
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
                  fontSize: Responsive.sp(5, context),
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              // onTap: () {
              //   Get.to(MedicineDetail());
              // },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Container(
                  height: Responsive.height(24, context),
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
                                        fontSize: Responsive.sp(4.5, context),
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontBold,
                                        letterSpacing: 0),
                              ),
                              SizedBox(
                                height: Responsive.height(0.3, context),
                              ),
                              TextWidget(
                                // FIXME: add Medicine detail
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
                                        fontSize: Responsive.sp(3.5, context)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    SvgIcon.pill,
                                    color: AppColors.primaryColor,
                                    height: Responsive.height(2, context),
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
                                          fontSize: Responsive.sp(3.5, context),
                                        ),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(3, context),
                                  ),
                                  SvgPicture.asset(
                                    SvgIcon.Rx,
                                    color: AppColors.primaryColor,
                                    height: Responsive.height(1.8, context),
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
                                          fontSize: Responsive.sp(3.5, context),
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Responsive.height(1, context),
                              ),
                              SizedBox(
                                height: Responsive.height(4.4, context),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(MedicineDetail());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.splashdetail
                                            .withOpacity(0.7),
                                        fixedSize: Size(
                                            Responsive.width(48, context), 0),
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
                                                  fontSize: Responsive.sp(
                                                      3.5, context),
                                                  color: AppColors.dark,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      AppFont.fontMedium),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(2, context),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: Responsive.height(2.3, context),
                                          color: AppColors.dark,
                                        )
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              if (homeController.isSaveMedicine[index]) {
                                homeController.isSaveMedicine[index] = false;
                              } else {
                                homeController.isSaveMedicine[index] = true;
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 39,
                                width: 39,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.splashdetail),
                                child: Padding(
                                  padding: homeController.isSaveMedicine[index]
                                      ? EdgeInsets.all(8.0)
                                      : EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    homeController.isSaveMedicine[index]
                                        ? SvgIcon.bookmark
                                        : SvgIcon.fillbookmark,
                                    height: Responsive.height(1.8, context),
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
            );
          },
        ),
      ),
    );
  }
}

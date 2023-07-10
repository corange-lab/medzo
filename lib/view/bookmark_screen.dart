import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(15),
          child: TextWidget(
            ConstString.bookmark,
            style: TextStyle(
              fontSize: Responsive.sp(4.5, context),
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: const Color(0xFF0D0D0D),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                child: Container(
                  height: Responsive.height(22, context),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                            color: Colors.grey.withOpacity(0.2))
                      ],
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5)),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextWidget(
                                "Azithromycin",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        fontSize: Responsive.sp(3.8, context),
                                        color: AppColors.darkPrimaryColor,
                                        fontFamily: AppFont.fontBold,
                                        letterSpacing: 0),
                              ),
                              TextWidget(
                                "A fast acting antibiotic.\nTackles infections effectively",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        height: 1.5,
                                        color: AppColors.grey.withOpacity(0.5),
                                        fontFamily: AppFont.fontFamily,
                                        fontSize: Responsive.sp(2.8, context)),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryColor,
                                    size: Responsive.height(2.5, context),
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryColor,
                                    size: Responsive.height(2.5, context),
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryColor,
                                    size: Responsive.height(2.5, context),
                                  ),
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryColor,
                                    size: Responsive.height(2.5, context),
                                  ),
                                  Icon(
                                    Icons.star_outline_rounded,
                                    color: AppColors.primaryColor,
                                    size: Responsive.height(2.5, context),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    SvgIcon.pill,
                                    color: AppColors.primaryColor,
                                    height: Responsive.height(1.9, context),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(1, context),
                                  ),
                                  TextWidget(
                                    ConstString.antibiotic,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: Responsive.sp(2.8, context),
                                        ),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(2, context),
                                  ),
                                  SvgPicture.asset(
                                    SvgIcon.Rx,
                                    color: AppColors.primaryColor,
                                    height: Responsive.height(1.7, context),
                                  ),
                                  SizedBox(
                                    width: Responsive.width(1, context),
                                  ),
                                  TextWidget(
                                    ConstString.prescribed,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: AppColors.primaryColor,
                                          fontSize: Responsive.sp(2.8, context),
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Responsive.height(4, context),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(const MedicineDetail());
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColors.splashdetail
                                            .withOpacity(0.7),
                                        fixedSize: Size(
                                            Responsive.width(40, context), 0),
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: AppColors.grey
                                                    .withOpacity(0.1),
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        TextWidget(
                                          ConstString.viewmoredetails,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: AppColors.dark,
                                                  fontFamily:
                                                      AppFont.fontFamily),
                                        ),
                                        SizedBox(
                                          width: Responsive.width(1, context),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: Responsive.height(1.8, context),
                                          color: const Color(0xff474747),
                                        )
                                      ],
                                    )),
                              )
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
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                SvgIcon.fillbookmark,
                                height: Responsive.height(2, context),
                              ),
                            ),
                          ),
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

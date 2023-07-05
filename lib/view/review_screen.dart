import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  var rating = 0.0;

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
            ConstString.addreview,
            style: TextStyle(
              fontSize: Responsive.sp(3.8, context),
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: const Color(0xFF0D0D0D),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: Responsive.height(3, context),
                ),
                TextWidget(
                  ConstString.writereview,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.sp(5.3, context),
                      letterSpacing: 0,
                      fontFamily: AppFont.fontFamilysemi),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                TextWidget(
                  ConstString.leavereview,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: Responsive.sp(3.3, context),
                      letterSpacing: 0,
                      color: AppColors.grey.withOpacity(0.8),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: Responsive.height(3, context),
                ),
                Image.asset(
                  AppImages.pillw,
                  height: Responsive.height(13, context),
                ),
                SizedBox(
                  height: Responsive.height(0.5, context),
                ),
                TextWidget(
                  "Azithromycin",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Responsive.sp(4, context),
                      letterSpacing: 0,
                      fontFamily: AppFont.fontFamilysemi),
                ),
                SizedBox(
                  height: Responsive.height(4, context),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextWidget(
                    ConstString.rateproduct,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.sp(3.5, context),
                        letterSpacing: 0.5,
                        fontFamily: AppFont.fontFamilysemi),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(0.5, context),
                ),
                RatingBar(
                  filledIcon: Icons.star_rounded,
                  emptyIcon: Icons.star_outline_rounded,
                  onRatingChanged: (v) {
                    setState(() {
                      rating = v;
                    });
                  },
                  filledColor: AppColors.primaryColor,
                  emptyColor: AppColors.primaryColor,
                  size: Responsive.height(3.4, context),
                ),
                SizedBox(
                  height: Responsive.height(2, context),
                ),
                Row(
                  children: [
                    TextWidget(
                      ConstString.review,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: Responsive.sp(3.5, context),
                              letterSpacing: 0.5,
                              fontFamily: AppFont.fontFamilysemi),
                    ),
                    SizedBox(
                      width: Responsive.width(1, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: SvgPicture.asset(SvgIcon.info,height: Responsive.height(2.3, context),)
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    cursorColor: AppColors.grey,
                    decoration: InputDecoration(
                      filled: true,
                      enabled: true,
                      fillColor: AppColors.searchbar.withOpacity(0.5),
                      hintText: "Write a review...",
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
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextWidget(
                    "210 character required",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.icongrey,
                        fontSize: Responsive.sp(2.5, context)),
                  ),
                ),
                SizedBox(
                  height: Responsive.height(10, context),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(Responsive.width(50, context), 45),
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: TextWidget(
                    ConstString.submit,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

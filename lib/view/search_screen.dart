import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
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
                    height: Responsive.height(2, context),
                  )),
              title: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: Responsive.height(6, context),
                    child: TextFormField(
                      autofocus: false,
                      controller: controller.searchController,
                      cursorColor: AppColors.grey,
                      decoration: InputDecoration(
                        filled: true,
                        enabled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: IconButton(
                            onPressed: () {
                              controller.searchController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: Responsive.height(3, context),
                            ),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, left: 10),
                          child: SvgPicture.asset(
                            SvgIcon.search,
                            height: Responsive.height(2, context),
                          ),
                        ),
                        fillColor: AppColors.splashdetail,
                        hintText: "Search here",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: Responsive.sp(4, context)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.whitehome, width: 0.5),
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.height(45, context),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.searchList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          horizontalTitleGap: 0,
                          titleAlignment: ListTileTitleAlignment.titleHeight,
                          leading: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SvgPicture.asset(
                              controller.searchIcons[index],
                              height: Responsive.height(3, context),
                            ),
                          ),
                          title: TextWidget(
                            controller.searchList[index],
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    color: AppColors.darkPrimaryColor,
                                    fontFamily: AppFont.fontFamilysemi,
                                    letterSpacing: 0,
                                    fontSize: Responsive.sp(4.2, context)),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: Responsive.height(2, context),
                            color: AppColors.lightGrey,
                          ),
                          subtitle: TextWidget(
                            controller.searchsubtitleList[index],
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: AppColors.grey,
                                  fontFamily: AppFont.fontMedium,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0,
                                  fontSize: Responsive.sp(3.2, context),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(),
                  TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        ConstString.viewall1,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.primaryColor,
                            height: 2,
                            fontSize: Responsive.sp(4, context),
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFont.fontFamilysemi),
                      ))
                ],
              ),
            ));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/home_controller.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
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
                  height: 15,
                )),
            title: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                ConstString.allcategory,
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
          body: Center(child: categoryWidget(controller, context)),
        );
      },
    );
  }

  Container categoryWidget(HomeController controller, BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.categoryImage.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.4),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      controller.categoryImage[index],
                      height: 40,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      controller.categoryName[index],
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          fontSize: 12,
                          fontFamily: AppFont.fontMedium,
                          letterSpacing: 0,
                          color: AppColors.grey),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
                  height: Responsive.height(1.6, context),
                )),
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextWidget(
                ConstString.allcategory,
                style: TextStyle(
                  fontSize: Responsive.sp(3.6, context),
                  fontFamily: AppFont.fontFamilysemi,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: const Color(0xFF0D0D0D),
                ),
              ),
            ),
            elevation: 2,
          ),
          body: Center(child: categoryWidget(controller, context)),
        );
      },
    );
  }

  Container categoryWidget(HomeController controller, BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.categoryImage.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 1.6),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(controller.categoryImage[index],height: Responsive.height(4.5, context),),
                    SizedBox(
                      height: Responsive.height(1.5, context),
                    ),
                    TextWidget(
                      controller.categoryName[index],
                      style: TextStyle(
                          fontSize: Responsive.sp(2.4, context),
                          fontFamily: AppFont.fontFamily,

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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/categorywise_medicine.dart';
import 'package:medzo/widgets/custom_widget.dart';

class CategoryScreen extends StatelessWidget {
  final List<CategoryDataModel>? CategoryList;

  CategoryScreen(this.CategoryList);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MedicineController(),
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

  Container categoryWidget(
      MedicineController controller, BuildContext context) {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: CategoryList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.4),
        itemBuilder: (context, index) {
          int imgIndex;
          if (index < 8) {
            imgIndex = index;
          } else {
            imgIndex = index - 8;
          }
          return InkWell(
            onTap: () async {
              await Get.to(
                  () => CategoryWiseMedicine(CategoryList!.elementAt(index)));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ClipRRect(
                    //   child: CachedNetworkImage(
                    //     height: 40,
                    //     fadeInCurve: Curves.easeIn,
                    //     imageUrl: CategoryList![index].image!,
                    //     errorWidget: (context, url, error) => Icon(Icons.error),
                    //     progressIndicatorBuilder:
                    //         (context, url, downloadProgress) => SizedBox(
                    //       width: 120,
                    //       child: Center(
                    //         child: CupertinoActivityIndicator(
                    //           color: AppColors.primaryColor,
                    //           animating: true,
                    //           radius: 12,
                    //         ),
                    //       ),
                    //     ),
                    //     fit: BoxFit.cover,
                    //   ),
                    //   borderRadius: BorderRadius.circular(7),
                    // ),
                    SvgPicture.asset(controller.categoryImages[imgIndex]),
                    SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      CategoryList![index].name!,
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

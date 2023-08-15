// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/category.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_widget.dart';

class CategoryWiseMedicine extends StatelessWidget {
  final List<CategoryDataModel>? categoryList;
  final int index;

  CategoryWiseMedicine(this.categoryList, this.index);

  final MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitehome,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
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
            "${categoryList![index].name}",
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
      body: StreamBuilder(
        stream: medicineController
            .getCategoryWiseMedicine(categoryList![index].id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data?.length != 0) {
            List<Medicine> medicineList = snapshot.data ?? [];
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: medicineList.length,
              itemBuilder: (context, index) {
                return MedicineWidget(
                  medicineDetail: medicineList.elementAt(index),
                  medicineBindPlace: MedicineBindPlace.CategoryWise,
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        SvgIcon.nodata,
                        scale: 0.5,
                      ),
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ConstString.noMedicine,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontSize: 18,
                          fontFamily: AppFont.fontBold),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

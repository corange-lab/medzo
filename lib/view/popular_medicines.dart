import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/medicine_controller.dart';
import 'package:medzo/model/medicine.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/enumeration.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/medicine_shimmer_widget.dart';
import 'package:medzo/widgets/medicine_widget.dart';

class PopularMedicines extends StatelessWidget {
  const PopularMedicines({super.key});

  @override
  Widget build(BuildContext context) {
    MedicineController controller = Get.put(MedicineController());
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
            ConstString.popularmedicine,
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
        stream: controller.fetchPopularMedicine(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MedicineShimmerWidget(
              itemCount: 5,
              height: 600,
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Medicine> medicineDetails = snapshot.data!;
            return ListView.builder(
              itemCount: medicineDetails.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MedicineWidget(
                    medicineDetail: medicineDetails.elementAt(index),
                    medicineBindPlace: MedicineBindPlace.dashboard);
              },
            );
          } else {
            return Center(
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
            );
          }
        },
      ),
    );
  }
}

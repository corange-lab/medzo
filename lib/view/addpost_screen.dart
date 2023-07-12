import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/dialogue.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class AddpostScreen extends StatelessWidget {
  const AddpostScreen({super.key});

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
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.newpost,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: Responsive.sp(4.8, context),
                fontFamily: AppFont.fontBold,
                letterSpacing: 0,
                color: AppColors.black),
          ),
        ),
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
      ),
      body: addpostWidget(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return successDialogue(
                  titleText: "Successful Uploaded",
                  subtitle: "Your post has been uploaded successfully.",
                  iconDialogue: SvgIcon.check_circle,
                  btntext: "View",
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(Responsive.width(50, context), 60),
              backgroundColor: AppColors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: TextWidget(
            ConstString.uploadpost,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: Responsive.sp(4, context),
                color: AppColors.buttontext, fontFamily: AppFont.fontMedium),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView addpostWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(20),
              width: SizerUtil.width,
              height: Responsive.height(20, context),
              decoration: BoxDecoration(
                  color: AppColors.tilecolor,
                  borderRadius: BorderRadius.circular(7),
                  border:
                      Border.all(color: AppColors.primaryColor, width: 0.5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgIcon.upload_image,
                    height: Responsive.height(4, context),
                  ),
                  SizedBox(
                    height: Responsive.height(2, context),
                  ),
                  TextWidget(
                    ConstString.uploadimage,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.darkyellow.withOpacity(0.9),
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.sp(4, context)),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: Responsive.height(1, context),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                ConstString.description,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: Responsive.sp(3.8, context),
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppFont.fontMedium),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              cursorColor: AppColors.grey,
              decoration: InputDecoration(
                filled: true,
                enabled: true,
                fillColor: AppColors.searchbar.withOpacity(0.5),
                hintText: "Add Description",
                hintStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: Responsive.sp(4, context)),
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
                  horizontal: 15,
                  vertical: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

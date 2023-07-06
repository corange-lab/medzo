import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
            ConstString.editprofile,
            style: TextStyle(
              fontSize: Responsive.sp(4, context),
              fontFamily: AppFont.fontFamilysemi,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: const Color(0xFF0D0D0D),
            ),
          ),
        ),
        elevation: 2,
      ),
      body: editProfileWidget(context),
    );
  }

  Stack editProfileWidget(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CircleAvatar(
                  maxRadius: Responsive.height(6, context),
                  backgroundColor: AppColors.tilecolor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 70,
          right: 115,
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: AppColors.blue, borderRadius: BorderRadius.circular(22.5)),
          ),
        )
      ],
    );
  }
}

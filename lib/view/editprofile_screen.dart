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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: CircleAvatar(
                  maxRadius: Responsive.height(6, context),
                  backgroundColor: AppColors.blue.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.blue.withOpacity(0.8),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(4, context),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextWidget(
                    ConstString.name,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey.withOpacity(0.9),
                        fontSize: Responsive.sp(3.3, context),
                        letterSpacing: 0.5,
                        fontFamily: AppFont.fontFamilysemi),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          SvgIcon.pencil_simple,
                          height: Responsive.height(2.2, context),
                        )),
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    hintText: "Enter your name",
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
                      horizontal: 15,
                      vertical: 10,
                    ),
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
                    ConstString.profession,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey.withOpacity(0.9),
                        fontSize: Responsive.sp(3.3, context),
                        letterSpacing: 0.5,
                        fontFamily: AppFont.fontFamilysemi),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
                    fillColor: AppColors.searchbar.withOpacity(0.5),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          SvgIcon.pencil_simple,
                          height: Responsive.height(2.2, context),
                        )),
                    hintText: "Enter your profession",
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
                      horizontal: 15,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.height(4, context),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Responsive.width(50, context), 45),
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: TextWidget(
                  ConstString.save,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColors.buttontext),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 75,
          right: 120,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(21)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  SvgIcon.pencil,
                  height: Responsive.height(2.5, context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors_theme.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

import '../utils/app_font.dart';

class search_screen extends StatelessWidget {
  const search_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.whitehome,
      appBar: AppBar(
        backgroundColor: ThemeColor.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: ThemeColor.darkPrimaryColor,
            )),
        title: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: TextWidget(
            ConstString.search,
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
    );
  }
}

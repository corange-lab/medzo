import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/chat_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

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
              height: Responsive.height(2, context),
            )),
        title: Align(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            ConstString.message,
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            horizontalTitleGap: 10,
            onTap: () {
              Get.to(ChatScreen());
            },
            leading: ClipOval(
              child: Container(
                height: 50,
                width: 50,
                child: index % 2 == 0
                    ? Image.asset("assets/user2.jpg")
                    : Image.asset("assets/user4.jpg"),
                // child: SvgPicture.asset("assets/user.svg",height: 50,),
              ),
            ),
            title: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                index % 2 == 0 ? "Cameron Williamson" : "Dianne Russell",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontFamily: AppFont.fontBold,
                    fontSize: Responsive.sp(4.2, context)),
              ),
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                index % 2 == 0
                    ? "Hello? interested in this loads?"
                    : "It's really nice working with you",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontFamily: index % 2 == 0
                        ? AppFont.fontFamilysemi
                        : AppFont.fontMedium,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    fontSize: Responsive.sp(3.5, context),
                    color: index % 2 == 0
                        ? AppColors.dark
                        : AppColors.grey.withOpacity(0.7)),
              ),
            ),
            trailing: TextWidget(
              index % 2 == 0 ? "10:32 pm" : "04:15 am",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.darkGrey,
                  fontSize: Responsive.sp(3, context)),
            ),
          );
        },
      ),
    );
  }
}

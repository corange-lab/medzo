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
              height: Responsive.height(1.6, context),
            )),
        title: TextWidget(
          ConstString.message,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: Responsive.sp(4, context),
              fontFamily: AppFont.fontBold,
              letterSpacing: 0,
              color: AppColors.black),
        ),
        elevation: 2,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Get.to(ChatScreen());
            },
            leading: CircleAvatar(
              backgroundColor: index % 2 == 0
                  ? AppColors.grey.withOpacity(0.2)
                  : AppColors.tilecolor,
              child: Icon(
                Icons.person,
                color: index % 2 == 0 ? Colors.black : AppColors.primaryColor,
              ),
            ),
            title: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                index % 2 == 0 ? "Cameron Williamson" : "Dianne Russell",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontFamily: AppFont.fontBold,
                    fontSize: Responsive.sp(3.5, context)),
              ),
            ),
            subtitle: Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                index % 2 == 0
                    ? "Hello? interested in this loads?"
                    : "It's really nice working with you",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontFamily: AppFont.fontFamilysemi,
                  fontSize: Responsive.sp(3.2, context),
                    color: index % 2 == 0
                        ? AppColors.dark.withOpacity(0.8)
                        : AppColors.grey.withOpacity(0.5)),
              ),
            ),
            trailing: TextWidget(
              index % 2 == 0 ? "10:32 pm" : "04:15 am",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.darkGrey,fontSize: Responsive.sp(2.7, context)),
            ),
          );
        },
      ),
    );
  }
}

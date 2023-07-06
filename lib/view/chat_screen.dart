import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        titleSpacing: 10,
        toolbarHeight: Responsive.height(7, context),
        backgroundColor: AppColors.white,
        elevation: 3,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
          child: CircleAvatar(
            backgroundColor: Colors.black26,
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              "Cameron Williamson",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: Responsive.sp(3.8, context),
                    fontFamily: AppFont.fontFamilysemi,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: AppColors.darkPrimaryColor,
                  ),
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            TextWidget(
              "Pharmacist",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                SvgIcon.more,
                height: Responsive.height(1.6, context),
              ))
        ],
      ),
      body: Container(
        height: SizerUtil.height,
        width: SizerUtil.width,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(AppImages.chatback), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      height: Responsive.height(5, context),
                      width: Responsive.width(50, context),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6))),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
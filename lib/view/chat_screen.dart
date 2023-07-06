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
      body: chatWidget(context),
      bottomNavigationBar: Container(
        height: Responsive.height(10, context),
        decoration: BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
              blurRadius: 0,
              spreadRadius: 1.5,
              color: AppColors.grey.withOpacity(0.1))
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: TextFormField(
                cursorColor: AppColors.grey,
                decoration: InputDecoration(
                  filled: true,
                  enabled: true,
                  prefixIcon: IconButton(
                      onPressed: () {}, icon: SvgPicture.asset(SvgIcon.smiley)),
                  fillColor: AppColors.white,
                  hintText: "Start typing...",
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Container chatWidget(BuildContext context) {
    return Container(
      height: SizerUtil.height,
      width: SizerUtil.width,
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(AppImages.chatback), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: Responsive.height(5, context),
                  width: Responsive.width(35, context),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 7),
                          child: TextWidget("Hi team 👋",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2, right: 7),
                          child: TextWidget("11:31 AM",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.darkyellow,
                                      fontSize: Responsive.sp(2.5, context))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: Responsive.height(5, context),
                  width: Responsive.width(55, context),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                          topRight: Radius.circular(6))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 7),
                          child: TextWidget("Anyone on for lunch today",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2, right: 7),
                          child: TextWidget("11:31 AM",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.darkyellow,
                                      fontSize: Responsive.sp(2.5, context))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 14,
                    backgroundColor: AppColors.tilecolor,
                    child: Icon(
                      Icons.person,
                      size: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 10),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        height: Responsive.height(7, context),
                        width: Responsive.width(50, context),
                        decoration: BoxDecoration(
                            color: AppColors.splashdetail,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                                topRight: Radius.circular(6))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                              child: Row(
                                children: [
                                  TextWidget(
                                    "Jav",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            fontSize: Responsive.sp(3, context),
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w800,
                                            fontFamily: AppFont.fontFamilysemi),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextWidget(
                                    "Engineering",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          fontSize: Responsive.sp(2.5, context),
                                          color: AppColors.chatgrey
                                              .withOpacity(0.7),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, left: 7),
                                child: TextWidget("I’m down! Any ideas??",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: AppColors.black)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 2, right: 7),
                                child: TextWidget("11:35 AM",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.grey,
                                            fontSize:
                                                Responsive.sp(2.5, context))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 3, bottom: 3, left: 42),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: Responsive.height(5, context),
                  width: Responsive.width(35, context),
                  decoration: BoxDecoration(
                      color: AppColors.splashdetail,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          topLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                          topRight: Radius.circular(6))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 7),
                          child: TextWidget("Let me know",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.black)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 2, right: 7),
                          child: TextWidget("11:35 AM",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey,
                                      fontSize: Responsive.sp(2.5, context))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

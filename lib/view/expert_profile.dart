import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/responsive.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/widgets/custom_widget.dart';

class ExpertProfileScreen extends StatelessWidget {
  const ExpertProfileScreen({super.key});

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
            ConstString.profile,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
            ),
            TextWidget(
              "Melissa Jones",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: Responsive.sp(3.8, context),
                    fontFamily: AppFont.fontFamilysemi,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                    color: const Color(0xFF0D0D0D),
                  ),
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "893 Followers",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColors.sky),
                ),
                SizedBox(
                  width: Responsive.width(1, context),
                ),
                Container(
                  height: 15,
                  width: 1,
                  color: AppColors.grey.withOpacity(0.2),
                ),
                SizedBox(
                  width: Responsive.width(1, context),
                ),
                TextWidget(
                  "101 Following",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: AppColors.sky),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Pharmacist @ CVS",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: AppColors.dark,
                      fontSize: Responsive.sp(3, context)),
                ),
                SizedBox(
                  width: Responsive.width(1, context),
                ),
                SvgPicture.asset(
                  SvgIcon.verify,
                  color: AppColors.blue,
                  height: Responsive.height(1.6, context),
                )
              ],
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            TextWidget(
              "4 year member, 41, Caucasian Female",
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.grey.withOpacity(0.8),
                  fontSize: Responsive.sp(3, context)),
            ),
            SizedBox(
              height: Responsive.height(2.5, context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              SvgIcon.chat,
                              height: Responsive.height(2.6, context),
                            ),
                            SizedBox(
                              width: Responsive.width(2, context),
                            ),
                            TextWidget(
                              ConstString.chat,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.dark,
                                      fontSize: Responsive.sp(3.5, context),
                                      fontFamily: AppFont.fontFamilysemi,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(Responsive.width(50, context), 45),
                            backgroundColor: AppColors.splashdetail,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: TextWidget(
                          ConstString.follownow,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColors.black,
                                  fontSize: Responsive.sp(3.5, context),
                                  fontFamily: AppFont.fontFamilysemi,
                                  fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            fixedSize: Size(Responsive.width(50, context), 45),
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.height(1, context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    ConstString.allpost,
                    style: TextStyle(
                        fontSize: Responsive.sp(4, context),
                        // 35
                        fontFamily: AppFont.fontFamilysemi,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: AppColors.darkPrimaryColor),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        ConstString.viewall,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: Responsive.sp(3.2, context),
                              height: 1,
                              fontWeight: FontWeight.w600,
                            ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Container(
                height: Responsive.height(33, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.tilecolor,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Ralph Edwards",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      subtitle: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "12hr",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.grey.withOpacity(0.5),fontSize: Responsive.sp(2.5, context)),
                            ),
                            TextSpan(
                              text: "• Updated ✔",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: AppColors.grey,fontSize: Responsive.sp(2.5, context)),
                            ),
                          ]))),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.splashdetail),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            SvgIcon.bookmark,
                            height: Responsive.height(2, context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Turns out avocados make the best supplements, an article on Vox claimed them to be the best providers for Vitamin C, start bulking up on them! Who cares how expensive they are!?",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.dark.withOpacity(0.5),
                            height: 1.5),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: Responsive.height(15, context),
                                  color: Colors.black12,
                                ),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: Responsive.height(15, context),
                              color: Colors.black12,
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                height: Responsive.height(17, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.purple.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          color: AppColors.purple.withOpacity(0.7),
                        ),
                      ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Courtney Henry",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "12hr",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: AppColors.grey.withOpacity(0.5),fontSize: Responsive.sp(2.5, context)),
                              ),
                              TextSpan(
                                text: "• Updated ✔",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.grey,fontSize: Responsive.sp(2.5, context)),
                              ),
                            ])),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.splashdetail),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            SvgIcon.bookmark,
                            height: Responsive.height(2, context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.dark.withOpacity(0.5),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                height: Responsive.height(17, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.tilecolor,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Kristin Watson",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "12hr",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: AppColors.grey.withOpacity(0.5),fontSize: Responsive.sp(2.5, context)),
                              ),
                              TextSpan(
                                text: "• Updated ✔",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.grey,fontSize: Responsive.sp(2.5, context)),
                              ),
                            ])),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.splashdetail),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            SvgIcon.bookmark,
                            height: Responsive.height(2, context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.dark.withOpacity(0.5),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                height: Responsive.height(17, context),
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.purple.withOpacity(0.2),
                        child: Icon(
                          Icons.person,
                          color: AppColors.purple.withOpacity(0.7),
                        ),
                      ),
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: TextWidget(
                          "Leslie Alexander",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "12hr",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                    color: AppColors.grey.withOpacity(0.5),fontSize: Responsive.sp(2.5, context)),
                              ),
                              TextSpan(
                                text: "• Updated ✔",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.grey,fontSize: Responsive.sp(2.5, context)),
                              ),
                            ])),
                      ),
                      trailing: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.splashdetail),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            SvgIcon.bookmark,
                            height: Responsive.height(2, context),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextWidget(
                        "Anybody know if you can take Genexa with Tylenol? My 7 year old son is having a cold and headaches, any advice would be appreciated!",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: AppColors.dark.withOpacity(0.5),
                            height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

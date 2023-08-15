import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/widgets/chat_message_content.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        titleSpacing: -12,
        toolbarHeight: 60,
        backgroundColor: AppColors.white,
        elevation: 3,
        shadowColor: AppColors.splashdetail.withOpacity(0.1),
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
          child: Row(
            children: [
              ClipOval(
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset("assets/user2.jpg"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    // FIXME: add User Name
                    "Cameron Williamson",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 15.5,
                          fontFamily: AppFont.fontBold,
                          letterSpacing: 0,
                          color: AppColors.darkPrimaryColor,
                        ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    // FIXME: add User Profession
                    "Pharmacist",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(letterSpacing: 0, fontSize: 12.5),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                SvgIcon.more,
                height: 16,
              ))
        ],
      ),
      body: chatWidget(context),
      bottomSheet: Container(
        height: 80,
        width: SizerUtil.width,
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
              flex: 8,
              child: TextFormField(
                maxLines: null,
                cursorColor: AppColors.grey,
                decoration: InputDecoration(
                  filled: true,
                  enabled: true,
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.only(top: 2),
                  //   child: IconButton(
                  //       onPressed: () {},
                  //       icon: SvgPicture.asset(
                  //         SvgIcon.smiley,
                  //         height: Responsive.height(3.2, context),
                  //       )),
                  // ),
                  fillColor: AppColors.white,
                  hintText: "Start typing...",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 14),
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
              flex: 1,
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    SvgIcon.at_icon,
                    height: 22,
                  )),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    SvgIcon.send,
                    height: 22,
                  )),
            ),
            SizedBox(
              width: 15,
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
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.chatback), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            MyChatWidget("Hi team 👋", "11:31 AM"),
            MyChatWidget("Anyone on for lunch today", "11:31 AM"),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/user5.jpg"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 60,
                        width: 220,
                        decoration: BoxDecoration(
                            color: AppColors.splashdetail,
                            borderRadius: const BorderRadius.only(
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
                                    // FIXME: add user Name
                                    "Jav",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            fontSize: 14,
                                            color: AppColors.black,
                                            fontFamily: AppFont.fontBold,
                                            letterSpacing: 0),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextWidget(
                                    // FIXME: add user Prefession
                                    "Engineering",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            fontSize: 11.5,
                                            color: AppColors.chatgrey
                                                .withOpacity(0.7),
                                            letterSpacing: 0),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5, left: 7),
                                // FIXME: add Chat Message
                                child: TextWidget("I’m down! Any ideas??",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.black,
                                            fontSize: 14)),
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
                                            fontSize: 10)),
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
                  margin: const EdgeInsets.only(right: 10),
                  height: 45,
                  width: 150,
                  decoration: BoxDecoration(
                      color: AppColors.splashdetail,
                      borderRadius: const BorderRadius.only(
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
                          // FIXME: add Chat Message
                          child: TextWidget("Let me know",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.black, fontSize: 14)),
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
                                      color: AppColors.grey, fontSize: 10)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}

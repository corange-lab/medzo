import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/profile_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user/other_profile_pic_widget.dart';

class BestMatchesScreen extends StatelessWidget {
  List<UserModel>? userList;

  BestMatchesScreen(this.userList);

  AllUserController userController = Get.put(AllUserController());

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
                height: 15,
              )),
          title: Align(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              ConstString.bestMatches,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 17.5,
                  fontFamily: AppFont.fontBold,
                  letterSpacing: 0,
                  color: AppColors.black),
            ),
          ),
          elevation: 3,
          shadowColor: AppColors.splashdetail.withOpacity(0.1),
        ),
        body: ListView.builder(
          itemCount: userList!.length,
          itemBuilder: (context, index) {
            if (userList!.isNotEmpty) {
              UserModel user = userList![index];
              return ListTile(
                onTap: () {
                  Get.to(()=>ProfileScreen(user.id!));
                },
                leading: OtherProfilePicWidget(
                  profilePictureUrl: user.profilePicture,
                  size: Size(45, 45),
                ),
                title: Text(
                  user.name ?? "Medzo User",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontFamily: AppFont.fontBold, fontSize: 15),
                ),
                subtitle: Text(
                  user.profession ?? "Profession",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontFamily: AppFont.fontMedium,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      fontSize: 12.5,
                      color: AppColors.grey),
                ),
              );
            } else {
              return Center(
                  child: Column(
                children: [
                  Icon(CupertinoIcons.person_circle,
                      color: AppColors.primaryColor, size: 45),
                  SizedBox(height: 10),
                  Text(
                    ConstString.noMatchesUser,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontFamily: AppFont.fontBold),
                  ),
                ],
              ));
            }
          },
        ));
  }
}

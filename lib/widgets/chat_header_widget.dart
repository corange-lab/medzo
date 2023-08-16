import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/all_user_controller.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user_profile_widget.dart';

class ChatHeader extends StatelessWidget {
  UserModel? userModel;

  ChatHeader(this.userModel);

  AllUserController userController = Get.put(AllUserController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          UserProfileWidget(userModel: userModel, size: Size(30, 30)),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "${userModel!.name ?? "Medzo User"}",
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
                "${userModel!.profession ?? "-"}",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(letterSpacing: 0, fontSize: 12.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

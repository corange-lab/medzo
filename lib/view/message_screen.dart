import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medzo/controller/chat_controller.dart';
import 'package:medzo/controller/user_repository.dart';
import 'package:medzo/model/chat_room.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/utils/string.dart';
import 'package:medzo/view/chat_screen.dart';
import 'package:medzo/widgets/custom_widget.dart';
import 'package:medzo/widgets/user_profile_widget.dart';

class MessageScreen extends StatelessWidget {
  ChatController chatController = Get.put(ChatController());

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
              ConstString.message,
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
        body: StreamBuilder(
          stream: UserRepository.instance.streamAllUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              List<UserModel> user = snapshot.data!;

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: user.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    horizontalTitleGap: 10,
                    onTap: () async {
                      ChatRoom? chatRoom =
                          await chatController.getChatRoom(user[index].id!);

                      if (chatRoom != null) {
                        Get.to(()=>ChatScreen(
                          userId: user[index].id,
                          userModel: user[index],
                          chatRoom: chatRoom,
                        ));
                      }
                    },
                    leading: UserProfileWidget(userModel: user[index]),
                    title: Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        // FIXME: add User name
                        "${user[index].name ?? "Medzo User"}",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontFamily: AppFont.fontBold, fontSize: 15),
                      ),
                    ),
                    subtitle: Align(
                      alignment: Alignment.topLeft,
                      child: TextWidget(
                        // FIXME: add User Last Message
                        "Hello? interested in this loads?",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontFamily: AppFont.fontMedium,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                            fontSize: 12.5,
                            color: AppColors.grey),
                      ),
                    ),
                    trailing: TextWidget(
                      "10:32 pm",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.darkGrey, fontSize: 10),
                    ),
                  );
                },
              );
            } else {
              return Text("No Data Found");
            }
          },
        ));
  }
}

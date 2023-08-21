import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:shimmer/shimmer.dart';

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
          stream: chatController.getChatUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ));
            }

            if (snapshot.hasData) {
              QuerySnapshot user = snapshot.data as QuerySnapshot;

              if (user.docs.length > 0) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: user.docs.length,
                  itemBuilder: (context, index) {
                    ChatRoom chatRoom = ChatRoom.fromMap(
                        user.docs[index].data() as Map<String, dynamic>);

                    Map<String, dynamic> participants = chatRoom.participants!;

                    List<String> participantKey = participants.keys.toList();

                    participantKey.remove(chatController.currentUser);

                    return FutureBuilder(
                      future:
                          UserRepository.instance.fetchUser(participantKey[0]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          UserModel userModel = snapshot.data as UserModel;

                          String lastMessageTime =
                              chatController.formatTimestamp(
                                  chatRoom.lastMessageTime.toString());

                          return ListTile(
                            horizontalTitleGap: 10,
                            onTap: () async {
                              ChatRoom? chatRoom = await chatController
                                  .getChatRoom(userModel.id!);

                              if (chatRoom != null) {
                                Get.to(() => ChatScreen(
                                      userModel: userModel,
                                      chatRoom: chatRoom,
                                    ));
                              }
                            },
                            leading: UserProfileWidget(userModel: userModel),
                            title: Align(
                              alignment: Alignment.topLeft,
                              child: TextWidget(
                                "${userModel.name ?? "Medzo User"}",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                        fontFamily: AppFont.fontBold,
                                        fontSize: 15),
                              ),
                            ),
                            subtitle: Align(
                              alignment: Alignment.topLeft,
                              child: TextWidget(
                                "${chatRoom.lastMessage.toString()}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontFamily: AppFont.fontMedium,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                        fontSize: 12.5,
                                        color: AppColors.grey),
                              ),
                            ),
                            trailing: TextWidget(
                              "${lastMessageTime}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: AppColors.darkGrey, fontSize: 11),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Shimmer.fromColors(
                              child: ListTile(
                                leading: CircleAvatar(),
                                title: Text("Medzo"),
                                trailing: Icon(Icons.chat),
                              ),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          SvgIcon.nodata,
                          scale: 0.5,
                        ),
                        width: 80,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        ConstString.nochat,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontSize: 18,
                            fontFamily: AppFont.fontBold),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        SvgIcon.nodata,
                        scale: 0.5,
                      ),
                      width: 80,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ConstString.nochat,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontSize: 18,
                          fontFamily: AppFont.fontBold),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

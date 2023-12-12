import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medzo/controller/chat_controller.dart';
import 'package:medzo/model/chat_room.dart';
import 'package:medzo/model/message_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/widgets/chat_header_widget.dart';
import 'package:medzo/widgets/chat_message_content.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  final UserModel? userModel;
  final ChatRoom? chatRoom;
  final String? receiverId;

  ChatScreen({this.userModel, this.chatRoom, this.receiverId});

  final ChatController chatController = Get.put(ChatController());

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
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
                chatController.messageText.clear();
              },
              icon: SvgPicture.asset(
                SvgIcon.backarrow,
                height: 15,
              )),
          title: GestureDetector(
              // onTap: () {
              //   Get.off(() => ProfileScreen(userModel!.id!));
              // },
              child: ChatHeader(userModel)),
        ),
        body: chatWidget(context, userModel!),
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
                  focusNode: focusNode,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontSize: 14, height: 1.3, color: AppColors.black),
                  textCapitalization: TextCapitalization.sentences,
                  controller: chatController.messageText,
                  maxLines: null,
                  cursorColor: AppColors.grey,
                  decoration: InputDecoration(
                    filled: true,
                    enabled: true,
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
                    // prefixIcon: GestureDetector(
                    //   onTap: () {
                    //     FocusScope.of(context).requestFocus(focusNode);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                    //     child: SvgPicture.asset(
                    //       SvgIcon.smiley,
                    //       height: 20,
                    //     ),
                    //   ),
                    // )
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: IconButton(
              //       onPressed: () {
              //         chatController.messageText.text =
              //             chatController.messageText.text + "@";
              //         chatController.messageText.selection =
              //             TextSelection.fromPosition(TextPosition(
              //                 offset: chatController.messageText.text.length));
              //       },
              //       icon: SvgPicture.asset(
              //         SvgIcon.at_icon,
              //         height: 22,
              //       )),
              // ),
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () async {
                      String senderID = chatController.currentUser;
                      String? receiverID =
                          receiverId != null && receiverId != ""
                              ? receiverId
                              : chatRoom?.participants?.keys.first != senderID
                                  ? senderID
                                  : chatRoom?.participants?.keys.last;

                      await chatController.sendMessage(
                          context: context, receiverID: receiverID);
                    },
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
      ),
      onWillPop: () async {
        chatController.messageText.clear();
        return true;
      },
    );
  }

  Container chatWidget(BuildContext context, UserModel userModel) {
    return Container(
      height: SizerUtil.height,
      width: SizerUtil.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.chatback), fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90, left: 10, right: 10),
        child: StreamBuilder(
          stream: chatController.fetchMessages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                QuerySnapshot dataMessage = snapshot.data as QuerySnapshot;

                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: dataMessage.docs.length,
                  itemBuilder: (context, index) {
                    messageModel message = messageModel.fromMap(
                        dataMessage.docs[index].data() as Map<String, dynamic>);

                    bool isFirstInGroup = false;

                    if (index < dataMessage.docs.length - 1) {
                      messageModel nextMessage = messageModel.fromMap(
                          dataMessage.docs[index + 1].data()
                              as Map<String, dynamic>);
                      if (message.sender != nextMessage.sender) {
                        isFirstInGroup = true;
                      }
                    } else {
                      isFirstInGroup = true;
                    }

                    String userMessage = message.message.toString();
                    String messageDate =
                        DateFormat('jm').format(message.createdTime!);
                    bool sender = message.sender == chatController.currentUser;

                    return MyChatWidget(
                        userMessage, messageDate, sender, isFirstInGroup);
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("An Error Occured!!"),
                );
              } else {
                return Center(
                  child: Text(
                    "Hello 🤘",
                    style:
                        TextStyle(color: AppColors.primaryColor, fontSize: 30),
                  ),
                );
              }
            } else {
              return Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.primaryColor,
                  animating: true,
                  radius: 20,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

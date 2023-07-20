import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/chat/bloc/chat_bloc.dart';
import 'package:medzo/chat/bloc/chat_list_bloc.dart';
import 'package:medzo/chat/bloc/conversation_bloc.dart';
import 'package:medzo/chat/bloc/user_online_bloc.dart';
import 'package:medzo/chat/enums/enums.dart';
import 'package:medzo/chat/models/models.dart';
import 'package:medzo/chat/repository/conversation_repository.dart';
import 'package:medzo/chat/repository/upload_image_repo.dart';
import 'package:medzo/chat/view/chat_ui.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/widgets/custom_button_widget.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key, required this.conversationModel})
      : super(key: key);

  final ConversationModel conversationModel;

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? conversationId;
  int lastMinute = -1;
  String lastMessageSenderId = "";
  File? imageFile;
  bool isLoading = false;
  late ConversationModel conversation;
  late Stream<List<MessageModel>> _stream;

  @override
  void initState() {
    conversation = widget.conversationModel;
    ConversationsBloc.updateUnreadCount(conversation: conversation);
    super.initState();
    // ChatBloc().getMessages(
    //     conversationId:
    //         // widget.conversationId ?? conversationId!
    //         conversation.id!);
    _stream = ChatBloc().getMessages(
        conversationId:
            // widget.conversationId ?? conversationId!
            conversation.id!);
  }

  // @override
  // void didUpdateWidget(covariant ConversationsPage oldWidget) {
  //   ConversationsBloc.updateUnreadCount(conversation: widget.conversation);
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    ConversationsBloc.updateUnreadCount(conversation: conversation);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Future<String> findOrCreateConversation(
  //     {required String user1Id, required String user2Id}) async {
  //   String tempConversationId =
  //       await ConversationsBloc.findOrCreateConversation(
  //           user1Id: user1Id, user2Id: user2Id);
  //   conversationId = tempConversationId;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   return tempConversationId;
  // }
  Future getImage(bool showLoading) async {
    await UploadImageRepo.getInstance()
        .getImage(showLoading, false, context)
        .then((value) async {
      if (value != null) {
        if (showLoading) {
          setState(() {
            isLoading = true;
          });
        }
        await UploadImageRepo.getInstance()
            .uploadFile(value)
            .then((value) async {
          if (showLoading) {
            setState(() {
              isLoading = false;
              msgSend(value, true);
            });
          } else {
            await ConversationsBloc.updateGroupIcon(
                conversation: conversation, imageUrl: value);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return conversation.id == null
        ? const _LoadingUI()
        : Scaffold(
            backgroundColor: AppColors.chatBackgroundColor,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65),
                child: Column(
                  children: [
                    appbar(conversation, () async {
                      await getImage(false);
                    }, () {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => setState(() {}));
                    }, context),
                    const Divider(
                      endIndent: 0,
                      indent: 0,
                    )
                  ],
                )),
            body: SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamBuilder<List<MessageModel>>(
                        stream: _stream,
                        builder: (context, snapshot) {
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting) {
                          // print("---staus${snapshot.connectionState}");
                          //   return Center(
                          //       child: CircularProgressIndicator(
                          //     color: AppColors.primaryColor,
                          //   ));
                          // }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: SizedBox(),
                            );
                          } else {
                            if (snapshot.data == null) {
                              return Container();
                            }

                            final List<MessageModel> messagesList =
                                snapshot.data ?? [];

                            lastMinute = -1;
                            if (snapshot.data != null &&
                                snapshot.data!.isNotEmpty) {
                              lastMessageSenderId = snapshot.data![0].senderId;
                            }

                            return ListView.separated(
                                reverse: true,
                                controller: _scrollController,
                                itemCount: messagesList.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                            // height: 5,
                                            ),
                                itemBuilder: (BuildContext context, int index) {
                                  final bool isCurrentUser =
                                      FirebaseAuth.instance.currentUser?.uid ==
                                          messagesList[index].senderId;
                                  if (messagesList.length == 1) {
                                    return ShowTimeComponent(
                                      isFirstMessage: true,
                                      message: messagesList[index],
                                      isCurrentUser: isCurrentUser,
                                      privMessage: messagesList[index],
                                      profileImage:
                                          // staticImage,
                                          conversation.participants.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            messagesList[index].senderId,
                                        orElse: () {
                                          return ChatUserModel(
                                              numberOfUnreadMessages: 0,
                                              profileImage: staticImage,
                                              userId: "id",
                                              name: "name");
                                        },
                                      ).profileImage,
                                      isLastMessage: true,
                                      chatBubbleStyle: messagesList[index]
                                          .getChatBubbleCornerStyle,
                                    );
                                  }
                                  if (index == messagesList.length - 1 &&
                                      index != 0) {
                                    return ShowTimeComponent(
                                      isFirstMessage:
                                          messagesList[index].senderId !=
                                              messagesList[index - 1].senderId,
                                      message: messagesList[index],
                                      isCurrentUser: isCurrentUser,
                                      privMessage: messagesList[index - 1],
                                      profileImage:
                                          conversation.participants.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            messagesList[index].senderId,
                                        orElse: () {
                                          return ChatUserModel(
                                              numberOfUnreadMessages: 0,
                                              profileImage: staticImage,
                                              userId: "id",
                                              name: "name");
                                        },
                                      ).profileImage,
                                      isLastMessage: true,
                                      chatBubbleStyle: messagesList[index]
                                          .getChatBubbleCornerStyle,
                                    );
                                  } else if (index == 0) {
                                    return ChatBubble(
                                      isFirstMessage: true,
                                      text: messagesList[index].isImage
                                          ? messagesList[index].imageUrl!
                                          : messagesList[index].content!,
                                      isCurrentUser: isCurrentUser,
                                      isLastMessage: false,
                                      profileImage:
                                          conversation.participants.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            messagesList[index].senderId,
                                        orElse: () {
                                          return ChatUserModel(
                                              numberOfUnreadMessages: 0,
                                              profileImage: staticImage,
                                              userId: "id",
                                              name: "name");
                                        },
                                      ).profileImage,
                                      chatBubbleStyle: messagesList[index]
                                          .getChatBubbleCornerStyle,
                                      isImage: messagesList[index].isImage,
                                    );
                                  } else if (messagesList[index - 1]
                                          .createdTime
                                          .minute !=
                                      messagesList[index].createdTime.minute) {
                                    return ShowTimeComponent(
                                      isFirstMessage:
                                          messagesList[index].senderId !=
                                              messagesList[index - 1].senderId,
                                      message: messagesList[index],
                                      isCurrentUser: isCurrentUser,
                                      privMessage: messagesList[index - 1],
                                      isLastMessage: false,
                                      profileImage:
                                          conversation.participants.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            messagesList[index].senderId,
                                        orElse: () {
                                          return ChatUserModel(
                                              numberOfUnreadMessages: 0,
                                              profileImage: staticImage,
                                              userId: "id",
                                              name: "name");
                                        },
                                      ).profileImage,
                                      chatBubbleStyle: messagesList[index]
                                          .getChatBubbleCornerStyle,
                                    );
                                  } else {
                                    return ChatBubble(
                                      isFirstMessage:
                                          messagesList[index].senderId !=
                                              messagesList[index - 1].senderId,
                                      text: messagesList[index].isImage
                                          ? messagesList[index].imageUrl!
                                          : messagesList[index].content!,
                                      isCurrentUser: isCurrentUser,
                                      profileImage:
                                          conversation.participants.firstWhere(
                                        (element) =>
                                            element.userId ==
                                            messagesList[index].senderId,
                                        orElse: () {
                                          return ChatUserModel(
                                              numberOfUnreadMessages: 0,
                                              profileImage: staticImage,
                                              userId: "id",
                                              name: "name");
                                        },
                                      ).profileImage,
                                      isLastMessage:
                                          index == messagesList.length - 1,
                                      chatBubbleStyle: messagesList[index]
                                          .getChatBubbleCornerStyle,
                                      isImage: messagesList[index].isImage,
                                    );
                                  }
                                });
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(
                    indent: 0,
                    endIndent: 0,
                    height: 1,
                    color: AppColors.lightGrey,
                  ),
                  conversation.requestAcceptedIds
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: 20, top: 10, bottom: 10),
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                )
                              : SendMessageComponent(
                                  textController: _textController,
                                  onSend: () => msgSend(
                                      _textController.text.trim(), false),
                                  onSendImage: () => getImage(true),
                                ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: CustomButtonWidget(
                            title: 'acceptRequest',
                            padding: 8.0,
                            radius: 20,
                            onPressed: () async {
                              await ChatListBloc()
                                  .acceptRequest(conversation: conversation)
                                  .then((value) => conversation.copyWith(
                                      requestAcceptedIds:
                                          conversation.requestAcceptedIds
                                            ..add(FirebaseAuth
                                                .instance.currentUser!.uid)));
                              setState(() {});
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
  }

  List<MessageModel> setMSGCornerUI(List<MessageModel> msgList) {
    final newList = msgList.reversed.toList();
    print(newList[0]);
    int lm = -1;
    int isSender = -1;

    //? set first message corner
    newList[0].setChatBubbleCornerStyle = ChatBubbleCornerStyle.bothRightSide;
    lm = newList[0].createdTime.minute;

    //? set other messages corner
    for (int i = 1; i < newList.length - 1; i++) {
      // if matched
      if (newList[i].createdTime.minute == lm) {
        // set priv message corner
        newList[i - 1].setChatBubbleCornerStyle =
            ChatBubbleCornerStyle.topRightSide;

        // set current message corner
        newList[i].setChatBubbleCornerStyle =
            ChatBubbleCornerStyle.bottomRightSide;

        // newList[i].isNewMinute = true;
      } else {
        // set current message corner
        newList[i].setChatBubbleCornerStyle =
            ChatBubbleCornerStyle.bothRightSide;
      }
      lm = newList[i].createdTime.minute;
    }
    newList[newList.length - 1].setChatBubbleCornerStyle =
        ChatBubbleCornerStyle.bothRightSide;

    return newList.reversed.toList();
  }

  // ? send msg data
  Future<void> msgSend(String content, bool isUrl) async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!isUrl && _textController.text.trim().isEmpty) {
      return;
    }
    // final String user1Id = widget.conversation.participantsIds[0] ==
    //         FirebaseAuth.instance.currentUser!.uid
    //     ? widget.conversation.participantsIds[0]
    //     : widget.conversation.participantsIds[1];
    // final String user2Id = widget.conversation.participantsIds[0] ==
    //         FirebaseAuth.instance.currentUser!.uid
    //     ? widget.conversation.participantsIds[1]
    //     : widget.conversation.participantsIds[0];
    //
    // // create conversation if not exist
    // conversationId ??= await findOrCreateConversation(
    //   // user1Id: widget.currentUserId, user2Id: widget.otherUserId,
    //
    //   user1Id: user1Id, user2Id: user2Id,
    // );
    // save msg to firebase
    if (conversation.id == null) {
      return;
    }
    ChatBloc().sendMessage(conversation.id!, content, isUrl: isUrl).then(
      (_) async {
        await _scrollToBottom();
      },
    );

    // clean text field
    _textController.clear();
  }

  Future<void> _scrollToBottom() async {
    await _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()}${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()}${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()}${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays}${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours}${diff.inHours == 1 ? "h" : "h"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes}${diff.inMinutes == 1 ? "min" : "min"} ago";
  }
  return "just now";
}

AppBar appbar(ConversationModel conversation, Function onEditClick,
    Function onUpdate, BuildContext context) {
  return AppBar(
    backgroundColor: AppColors.chatBackgroundColor,
    automaticallyImplyLeading: false,
    leading: IconButton(
        splashRadius: 1,
        onPressed: () {
          Navigator.pop(context);
          FocusManager.instance.primaryFocus?.unfocus();
        },
        icon: Icon(Icons.arrow_back_ios_outlined, color: AppColors.grey)

        // Icons.(
        //   // image: AppImages.leftBackArrow,
        //   height: 20,
        //   width: 20,
        // )
        ),
    titleSpacing: 0.0,
    title: GestureDetector(
      onTap: conversation.isGroup
          ? () async => await Get.to(
                () => ChatGroupInfo(
                  conversation: conversation,
                ),
              )
          : () async {
              // TODO: go to profile screen
              //       await Get.to(() => ProfileScreenHome(
              //           userId: conversation.participants
              //               .firstWhere((element) =>
              //                   element.userId !=
              //                   FirebaseAuth.instance.currentUser?.uid)
              //               .userId));
            },
      child: StreamBuilder<ConversationModel>(
        stream: ConversationsRepository.getInstance()
            .getGroupIcon(conversation: conversation),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //  print('snapshot');
            //  print(snapshot.data);
            if (snapshot.data != null) {
              conversation = snapshot.data!;

              onUpdate();
            }
            return Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProfileAvatar(
                    conversation.isGroup
                        ? snapshot.data?.imageUrl ?? staticGroupImage
                        : (snapshot.data?.participants
                                .firstWhereOrNull((element) =>
                                    element.userId !=
                                    FirebaseAuth.instance.currentUser?.uid)
                                ?.profileImage ??
                            staticImage),
                    errorWidget: (context, url, error) => Image.network(
                        conversation.isGroup ? staticGroupImage : staticImage),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Text(
                          conversation.isGroup
                              ? conversation.groupName ?? 'Unknown'
                              : conversation.participants
                                      .firstWhereOrNull((element) =>
                                          element.userId !=
                                          FirebaseAuth
                                              .instance.currentUser?.uid)
                                      ?.name ??
                                  "Name",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      conversation.isGroup
                          ? Text(
                              '${conversation.participantsIds.length} members',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 12),
                            )
                          : StreamBuilder<Map<String, dynamic>>(
                              stream: OnlineUserBlock().showUserPresence(
                                  conversation.participants
                                          .firstWhereOrNull((element) =>
                                              element.userId !=
                                              FirebaseAuth
                                                  .instance.currentUser?.uid)
                                          ?.userId ??
                                      "1"),
                              builder: (context, snapshot) {
                                print("data---${snapshot.data}");
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!['presence']
                                        ? 'online'
                                        : 'offline',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: AppColors.graniteGray,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                  );
                                }
                                return const SizedBox();
                              },
                            )
                    ],
                  ),
                ),
              ],
            );
          }
          return Image.asset(
              'assets/${conversation.isGroup ? 'group.png' : 'one_user.png'}');
        },
      ),
    ),
    actions: [
      conversation.isGroup &&
              conversation.participantsIds[0] ==
                  FirebaseAuth.instance.currentUser!.uid
          ? Padding(
              padding: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
              child: IconButton(
                  splashRadius: 1,
                  onPressed: () => Get.to(UpdateChatGroupInfo(
                        conversation: conversation,
                      )),
                  icon: const Icon(Icons.edit)),
            )
          : const SizedBox()
    ],
  );
}

class _LoadingUI extends StatelessWidget {
  const _LoadingUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

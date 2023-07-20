import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medzo/chat/bloc/chat_list_bloc.dart';
import 'package:medzo/chat/extension/extensions.dart';
import 'package:medzo/chat/models/models.dart';
import 'package:medzo/chat/view/chat_ui.dart';
import 'package:medzo/chat/view/create_group_bottomsheet.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/assets.dart';
import 'package:medzo/widgets/expansion_tile_widget.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  TextEditingController searchController = TextEditingController();
  int requestCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "messages".tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              fontFamily: AppFont.fontFamily,
              color: AppColors.darkBlue),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  builder: (context) {
                    return const CreateGroupBottomSheet();
                  },
                );
              },
              child: const Image(
                image: AssetImage(AppImages.addEventsIcon),
                height: 33,
                width: 33,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 48,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.searchfieldColor,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {},
              child: CupertinoSearchTextField(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.searchfieldColor,
                    backgroundBlendMode: BlendMode.dstATop),
                enabled: true,
                controller: searchController,
                onSuffixTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  searchController.text = "";
                  setState(() {});
                },
                onChanged: (value) {
                  if (searchController.text == "" ||
                      searchController.text.isEmpty) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                  setState(() {});
                },
                prefixInsets: const EdgeInsets.only(top: 2, left: 8),
                placeholder: "Search",
                padding: const EdgeInsets.only(left: 6.5, top: 0),
              ),
            ),
          ),
          const Divider(color: Color(0xffEAEAEA), height: 1, thickness: 1.5),
          /*  Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Text(
                  "chatRequests".tr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkPrimaryColor),
                ),
                const Spacer(),
                ShowCountCircle(count: '$requestCount', radius: 12),
                const SizedBox(
                  width: 14,
                )
              ],
            ),
          ),*/
          Expanded(
            child: StreamBuilder<List<ConversationModel>>(
              stream: ChatListBloc().getConversations(
                  userId: FirebaseAuth.instance.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<ConversationModel> requestList = [];
                  if (snapshot.data == null ||
                      (snapshot.data?.isEmpty ?? true)) {
                    log("requestList.length ${requestList.length}",
                        name: "chatList");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("No Conversations at moment!",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 20)),
                      ],
                    );
                    // return ElevatedButton(
                    //   child: const Text("hii"),
                    //   onPressed: () async {
                    //     /*    await ConversationsBloc.findOrCreateConversation(
                    //         user1Id: FirebaseAuth.instance.currentUser!.uid,
                    //         user2Id: "4Fjsvek9h7e7QK54xPEkFbUKCbt2");*/
                    //   },
                    // );
                  }
                  for (var element in snapshot.data!) {
                    if (!(element.requestAcceptedIds
                        .contains(FirebaseAuth.instance.currentUser!.uid))) {
                      requestList.add(element);
                    }
                  }
                  return Column(
                    children: [
                      if (requestList.isNotEmpty)
                        CustomExpansionTileWidget(requestList: requestList),
                      const Divider(
                          color: Color(0xffEAEAEA), height: 1, thickness: 1.5),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(0),
                          itemCount: (snapshot.data?.length ?? 0),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                  color: Color(0xffEAEAEA),
                                  height: 1,
                                  thickness: 1.5),
                          itemBuilder: (BuildContext context, int index) {
                            final ConversationModel data =
                                snapshot.data![index];
                            if (data.requestAcceptedIds.contains(
                                FirebaseAuth.instance.currentUser!.uid)) {
                              if (searchController.text.isNotEmpty) {
                                if (data.participants
                                    .firstWhere((element) =>
                                        element.userId !=
                                        FirebaseAuth.instance.currentUser?.uid)
                                    .name
                                    .toLowerCase()
                                    .contains(searchController.text
                                        .trim()
                                        .toLowerCase())) {
                                  return ChatListWidget(
                                    conversationModel: snapshot.data![index],
                                  );
                                } else if (data.groupName != null &&
                                    data.groupName!.toLowerCase().contains(
                                        searchController.text
                                            .trim()
                                            .toLowerCase())) {
                                  return ChatListWidget(
                                    conversationModel: snapshot.data![index],
                                  );
                                }
                              } else {
                                return ChatListWidget(
                                  conversationModel: snapshot.data![index],
                                );
                              }
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({
    Key? key,
    required this.conversationModel,
  }) : super(key: key);
  final ConversationModel conversationModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Get.to(() => ConversationsPage(
              conversationModel: conversationModel,
              // userModel: conversationModel.participants.firstWhere((element) =>
              //     element.userId != FirebaseAuth.instance.currentUser?.uid),
            ));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularProfileAvatar(
              conversationModel.isGroup
                  ? (conversationModel.imageUrl ?? staticGroupImage)
                  : conversationModel.participants
                      .firstWhere(
                        (element) =>
                            element.userId !=
                            FirebaseAuth.instance.currentUser?.uid,
                        orElse: () => ChatUserModel(
                            name: "namesd dsd",
                            numberOfUnreadMessages: 0,
                            profileImage: staticImage,
                            userId: "dsd"),
                      )
                      .profileImage,
              cacheImage: true,
              animateFromOldImageOnUrlChange: true,
              borderColor: Colors.red,
              radius: 24,
              errorWidget: (context, url, error) => Image.network(
                  conversationModel.isGroup ? staticGroupImage : staticImage),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 170,
                      child: Text(
                        conversationModel.isGroup
                            ? (conversationModel.groupName ?? "Group")
                            : conversationModel.participants
                                .firstWhere(
                                  (element) =>
                                      element.userId !=
                                      FirebaseAuth.instance.currentUser?.uid,
                                  orElse: () => ChatUserModel(
                                      name: "namesd dsd",
                                      numberOfUnreadMessages: 0,
                                      profileImage: "sdsd",
                                      userId: "dsd"),
                                )
                                .name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 170,
                      child: Text(
                        conversationModel.lastMessageIsImage
                            ? "Image"
                            : conversationModel.lastMessageContent ??
                                "No Message",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: conversationModel.participants
                                      .firstWhere((element) =>
                                          element.userId ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .numberOfUnreadMessages !=
                                  0
                              ? AppColors.black
                              : AppColors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  conversationModel.lastUpdateTime.isToday
                      ? conversationModel.lastUpdateTime.chatDateTime()
                      : conversationModel.lastUpdateTime.isYesterday
                          ? 'Yesterday'
                          : DateFormat('MM/dd/yy')
                              .format(conversationModel.lastUpdateTime),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.graniteGray),
                ),
                const SizedBox(
                  height: 5,
                ),
                conversationModel.participants
                            .firstWhere((element) =>
                                element.userId ==
                                FirebaseAuth.instance.currentUser!.uid)
                            .numberOfUnreadMessages !=
                        0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: ShowCountCircle(
                            count: conversationModel.participants
                                .firstWhere(
                                    (element) =>
                                        element.userId ==
                                        FirebaseAuth.instance.currentUser!.uid,
                                    orElse: () => ChatUserModel(
                                        name: "",
                                        numberOfUnreadMessages: 0,
                                        profileImage: "",
                                        userId: "1"))
                                .numberOfUnreadMessages
                                .toString(),
                            radius: 13),
                      )
                    : const SizedBox()
              ],
            )
          ],
        ),
      ),
    );
  }
}

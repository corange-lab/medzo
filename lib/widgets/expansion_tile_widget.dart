import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:medzo/chat/bloc/chat_list_bloc.dart';
import 'package:medzo/chat/models/models.dart';
import 'package:medzo/chat/view/widget/widget.dart';
import 'package:medzo/theme/colors.dart';

class CustomExpansionTileWidget extends StatefulWidget {
  final List<ConversationModel> requestList;
  const CustomExpansionTileWidget({Key? key, required this.requestList})
      : super(key: key);

  @override
  State<CustomExpansionTileWidget> createState() =>
      _CustomExpansionTileWidgetState();
}

class _CustomExpansionTileWidgetState extends State<CustomExpansionTileWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          children: [
            Text(
              "chatRequests".tr,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.darkPrimaryColor),
            ),
          ],
        ),
      ),
      trailing:
          ShowCountCircle(count: '${widget.requestList.length}', radius: 15),
      children: [
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.requestList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: CircularProfileAvatar(
                      widget.requestList[index].imageUrl ?? staticImage,
                      cacheImage: true,
                      animateFromOldImageOnUrlChange: true,
                      borderColor: Colors.red,
                      //initialsText: const Text("A"),
                      radius: 20,
                      errorWidget: (context, url, error) => Image.network(
                          widget.requestList[index].isGroup
                              ? staticGroupImage
                              : staticImage),
                    ),
                    title: SizedBox(
                      width: MediaQuery.of(context).size.width - 170,
                      child: Text(
                        widget.requestList[index].isGroup
                            ? (widget.requestList[index].groupName ?? "Group")
                            : widget.requestList[index].participants
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
                        style: TextStyle(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: ElevatedButton(
                      style: ButtonStyle(
                          splashFactory: NoSplash.splashFactory,
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(5.0)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor),
                          overlayColor: MaterialStateProperty.all<Color>(
                              AppColors.textFieldBorderColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ))),
                      onPressed: () async {
                        await ChatListBloc().acceptRequest(
                            conversation: widget.requestList[index]);
                      },
                      child: Text(
                        "accept".tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: AppColors.darkPrimaryColor),
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
      onExpansionChanged: (bool expanding) =>
          setState(() => this.isExpanded = expanding),
    );
  }
}

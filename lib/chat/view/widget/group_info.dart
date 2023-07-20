part of './widget.dart';

class ChatGroupInfo extends StatefulWidget {
  ConversationModel conversation;
  ChatGroupInfo({Key? key, required this.conversation}) : super(key: key);

  @override
  State<ChatGroupInfo> createState() => _ChatGroupInfoState();
}

class _ChatGroupInfoState extends State<ChatGroupInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePicWidget;
    const double profilePicElevation = 10;
    const double profilePicRadius = 70;
    Size size = MediaQuery.of(context).size;
    if (widget.conversation.imageUrl != null) {
      profilePicWidget = CircularProfileAvatar(
        widget.conversation.imageUrl,
        radius: profilePicRadius,
        elevation: profilePicElevation,
        placeHolder: (_, __) => CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
        errorWidget: (_, __, ___) {
          return Image(
            image: const AssetImage(AppImages.errorImage),
            fit: BoxFit.contain,
            color: Colors.grey,
            height: size.height,
            width: size.width,
          );
        },
      );
    } else {
      profilePicWidget = Center(
        child: Image(
          image: const AssetImage(AppImages.group),
          color: AppColors.graniteGray,
          width: 40,
          height: 40,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            customAppBar(context),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: 130,
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2.5,
                          color: Colors.white,
                        ),
                        color: AppColors.lightGrey,
                      ),
                      child: profilePicWidget,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Group Name",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: 60,
                        width: size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.textFieldBorderColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${widget.conversation.groupName}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Group Members",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.conversation.participants.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.textFieldBorderColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UserProfileWidget(
                                  userModel: UserModel(
                                      name: widget.conversation
                                          .participants[index].name,
                                      profilePicture: widget.conversation
                                          .participants[index].profileImage),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 15, 10, 0),
                                  child: SizedBox(
                                    width: size.width - 240,
                                    child: Text(
                                      widget.conversation.participants[index]
                                          .name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                widget.conversation.participants[index]
                                            .userId ==
                                        widget.conversation.participantsIds[0]
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    AppColors.darkPrimaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                AppColors.lightButtonBackground,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              "Group Admin",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors
                                                        .darkPrimaryColor,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Container customAppBar(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(
                color: AppColors.grey,
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  '${widget.conversation.groupName} Info',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const SizedBox(
              //   width: 20,
              // ),
            ],
          ),
          Divider(
            endIndent: 0,
            indent: 0,
            color: AppColors.lightGrey,
          ),
        ],
      ),
    );
  }
}

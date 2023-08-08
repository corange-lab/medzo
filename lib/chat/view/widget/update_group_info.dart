part of './widget.dart';

class UpdateChatGroupInfo extends StatefulWidget {
  ConversationModel conversation;
  UpdateChatGroupInfo({Key? key, required this.conversation}) : super(key: key);

  @override
  State<UpdateChatGroupInfo> createState() => _UpdateChatGroupInfoState();
}

class _UpdateChatGroupInfoState extends State<UpdateChatGroupInfo> {
  final AppStorage appStorage = AppStorage();

  AuthApi authApi = AuthApi.instance;

  TextEditingController displayNameTextEditingController =
      TextEditingController();

  File? _image;

  final displayNameFocusNode = FocusNode();
  List<String> userIds = [];

  String? imageUrl;
  bool isLoading = false;
  bool isListLoading = false;
  bool isUploading = false, isSaveChanges = false;
  // List<ChatUserModel> selectedGroupUsers = [];
  List<UserModel> selectedGroupUsers = [];
  List<ChatUserModel> finalGroupUsers = [];
  List<String> requestAcceptIds = [];

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    if (widget.conversation.imageUrl != null) {
      imageUrl = widget.conversation.imageUrl;
    }
    if (widget.conversation.groupName != null) {
      displayNameTextEditingController.text = widget.conversation.groupName!;
    }
    if (widget.conversation.requestAcceptedIds.isNotEmpty) {
      requestAcceptIds = widget.conversation.requestAcceptedIds;
    }
    if (widget.conversation.participants.isNotEmpty) {
      // isLoading = true;
      // selectedGroupUsers = await UserRepository.getInstance()
      //         .getUsersByIds(widget.conversation.participantsIds) ??
      //     [];
      // isLoading = false;
      isListLoading = true;
      finalGroupUsers = widget.conversation.participants;

      for (int i = 0; i < widget.conversation.participants.length; i++) {
        var userModel = await authApi.getUserDetails(
            userId: widget.conversation.participants[i].userId, isLogin: false);

        if (userModel != null) {
          selectedGroupUsers.add(userModel);
          userIds.add(selectedGroupUsers[i].id!);
        }

        // selectedGroupUsers.add(UserModel(
        //     profilePicture: widget.conversation.participants[i].profileImage,
        //     id: widget.conversation.participants[i].userId,
        //     name: widget.conversation.participants[i].name));
      }
      print("---list--${selectedGroupUsers.length}---${userIds}");

      isListLoading = false;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profilePicWidget;
    const double profilePicElevation = 10;
    const double profilePicRadius = 70;
    Size size = MediaQuery.of(context).size;
    if (_image != null) {
      profilePicWidget = Material(
        type: MaterialType.circle,
        color: Colors.white,
        elevation: profilePicElevation,
        child: CircleAvatar(
          backgroundColor: AppColors.lightGrey,
          radius: profilePicRadius,
          backgroundImage: FileImage(_image!),
        ),
      );
    } else if (!isLoading && widget.conversation.imageUrl != null) {
      profilePicWidget = CircularProfileAvatar(
        widget.conversation.imageUrl,
        radius: profilePicRadius,
        elevation: profilePicElevation,
        placeHolder: (_, __) => CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor)),
        errorWidget: (_, __, ___) {
          return Image(
            image: const AssetImage(AppImages.errorImage),
            fit: BoxFit.cover,
            color: Colors.grey,
            height: size.height,
            width: size.width,
          );
        },
      );
    } else {
      profilePicWidget = Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: Image(
            image: const AssetImage(AppImages.cameraIcon),
            color: AppColors.primaryColor,
            width: 20,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customAppBar(context),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: null,
                      child: Container(
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
                        child: StreamBuilder<ConversationModel>(
                          stream: ConversationsRepository.getInstance()
                              .getGroupIcon(conversation: widget.conversation),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null) {
                                widget.conversation = snapshot.data!;
                              }
                              return isLoading
                                  ? CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    )
                                  : Stack(
                                      children: [
                                        profilePicWidget,
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Card(
                                            color: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            elevation: 10,
                                            child: InkWell(
                                              onTap: () {
                                                updateImage(true);
                                              },
                                              child: const Image(
                                                  height: 40,
                                                  width: 40,
                                                  image: AssetImage(
                                                      AppImages.unselectedPic)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                            }
                            return Image.asset('assets/group.png');
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        height: 75,
                        child: CustomTextEditingController(
                          hintText: 'Group name',
                          focusNode: displayNameFocusNode,
                          maxLines: 1,
                          label: 'Group name',
                          labelEnabled: true,
                          outsideLabelEnabled: true,
                          controller: displayNameTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Text(
                            "Group Members",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                    isListLoading
                        ? CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: selectedGroupUsers.length,
                            itemBuilder: (_, index) {
                              return Container(
                                width: selectedGroupUsers[index].id ==
                                        widget.conversation.participantsIds[0]
                                    ? size.width - 32
                                    : size.width - 32,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.textFieldBorderColor),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UserProfileWidget(
                                        userModel: UserModel(
                                            name:
                                                selectedGroupUsers[index].name,
                                            profilePicture:
                                                selectedGroupUsers[index]
                                                    .profilePicture),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 15, 10, 0),
                                        child: SizedBox(
                                          width: size.width - 230,
                                          child: Text(
                                            selectedGroupUsers[index].name ??
                                                "",
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
                                      selectedGroupUsers[index].id ==
                                              widget.conversation
                                                  .participantsIds[0]
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 13),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColors
                                                          .darkPrimaryColor),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors
                                                      .lightButtonBackground,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    "Group Admin",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: AppColors
                                                              .darkPrimaryColor,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : selectedGroupUsers[index].id ==
                                                  widget.conversation
                                                      .participantsIds[0]
                                              ? const SizedBox()
                                              : Row(
                                                  children: [
                                                    // Spacer(),
                                                    SizedBox(
                                                      width: size.width - 332,
                                                    ),
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      onPressed: () async {
                                                        if (finalGroupUsers
                                                                    .length >
                                                                3 &&
                                                            selectedGroupUsers
                                                                    .length >
                                                                3) {
                                                          String id =
                                                              finalGroupUsers[
                                                                      index]
                                                                  .userId;

                                                          requestAcceptIds
                                                              .remove(id);

                                                          finalGroupUsers
                                                              .removeAt(index);
                                                          selectedGroupUsers
                                                              .removeAt(index);
                                                          userIds
                                                              .removeAt(index);
                                                          setState(() {});
                                                        } else {
                                                          showInSnackBar(
                                                              "The group must be at least 3 members",
                                                              isSuccess: false);
                                                        }
                                                      },
                                                      icon: Image(
                                                        image: const AssetImage(
                                                            AppImages
                                                                .crossIcon),
                                                        color: AppColors
                                                            .darkPrimaryColor,
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 5,
                              );
                            },
                          ),
                  ],
                ),
              ),
            )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: isSaveChanges
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : CustomButton(
                      title: 'saveChanges'.tr,
                      onPressed: onSubmit,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (isLoading) {
      return showInSnackBar("Please wait till uploading the image",
          isSuccess: false);
    } else {
      isSaveChanges = true;
      setState(() {});
      FocusManager.instance.primaryFocus?.unfocus();
      try {
        ConversationModel conversionModel =
            await ConversationsBloc.getConversationModelById(
                conversationId: widget.conversation.id!);

        ConversationModel updateConversation =
            await ConversationsRepository.getInstance().updateConversation(
                conversation: conversionModel.copyWith(
          imageUrl: imageUrl,
          groupName: displayNameTextEditingController.text,
          participants: finalGroupUsers,
          participantsIds: userIds,
          requestAcceptedIds: requestAcceptIds,
        ));

        if (imageUrl != null) {
          await ConversationsBloc.updateGroupIcon(
            conversation: updateConversation,
            imageUrl: updateConversation.imageUrl!,
          );
        }
        if (displayNameTextEditingController.text.isEmpty) {
          isSaveChanges = false;
          setState(() {});
          return showInSnackBar("Please enter group name", isSuccess: false);
        } else {
          await ConversationsBloc.updateGroupName(
            conversation: updateConversation,
            grpName: updateConversation.groupName!,
          );
        }
        if (userIds.isNotEmpty && selectedGroupUsers.isNotEmpty) {
          await ConversationsBloc.updateGroupMembers(
            conversation: updateConversation,
            participants: updateConversation.participants,
            participantsIds: updateConversation.participantsIds,
            requestAcceptedIds: updateConversation.requestAcceptedIds,
          );
        }
      } catch (e) {
        return showInSnackBar("$e");
      }
      isSaveChanges = false;
      setState(() {});
      Get.back();
    }
  }

  Future updateImage(bool showLoading) async {
    await UploadImageRepo.getInstance()
        .getImage(true, true, context)
        .then((value) async {
      _image = value;
      if (value != null) {
        if (showLoading) {
          setState(() {
            isLoading = true;
          });
        }
        await UploadImageRepo.getInstance()
            .uploadFile(value)
            .then((value) async {
          imageUrl = value;
          if (mounted) {
            setState(() {});
          }
          if (showLoading) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    });
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
                  'Update ${widget.conversation.groupName} Info',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
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

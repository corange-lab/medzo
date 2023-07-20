import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medzo/api/auth_api.dart';
import 'package:medzo/chat/bloc/conversation_bloc.dart';
import 'package:medzo/chat/models/models.dart';
import 'package:medzo/model/invite_people_model.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/model/users_response.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/utils.dart';
import 'package:medzo/widgets/custom_button.dart';
import 'package:medzo/widgets/custom_textfield.dart';
import 'package:medzo/widgets/user_profile_widget.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({Key? key}) : super(key: key);

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  int currentPageNumber = 0;
  RxBool hasNextPage = true.obs;
  RxBool isFirstLoadRunning = false.obs;
  RxBool isLoadMoreRunning = false.obs;
  bool isLoading = false;
  RxList<UserModel> mUsers = <UserModel>[].obs;
  final nameFocusNode = FocusNode();
  // RxList<Map<String, String>>? nUsers = [].obs as RxList<Map<String, String>>?;
  List<InvitePeople>? data;
  List<InvitePeople> invitedUser = [];
  RxList<InvitePeople> selectedInvitedUsers = <InvitePeople>[].obs;
  RxList<UserModel> selectedUsers = <UserModel>[].obs;
  RxList<UserModel> invitedUsers = <UserModel>[].obs;
  AuthApi authApi = AuthApi.instance;

  TextEditingController searchEditingController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();

  Future<void> _firstLoad() async {
    isFirstLoadRunning.value = true;
    try {
      AllUsersResponse? value = await authApi.fetchAllUsers(
          pageNumber: currentPageNumber, keyword: searchKeyword);

      print("---list--$value");
      if (value != null) {
        mUsers.value = value.users ?? [];
        mUsers.value.insertAll(0, invitedUsers);
      }
    } catch (err) {
      debugPrint('Something went wrong');
    }

    isFirstLoadRunning.value = false;
  }

  String? get searchKeyword {
    String searchKey = searchEditingController.text.trim().toLowerCase();
    return searchKey.isEmpty ? null : searchKey;
  }

  Future<void> _loadMore() async {
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false &&
        _controller.position.extentAfter < 300) {
      isLoadMoreRunning.value = true;
      currentPageNumber += 1;
      try {
        AllUsersResponse? value = await authApi.fetchAllUsers(
            pageNumber: currentPageNumber, keyword: searchKeyword);

        if (value != null && value.users != null && value.users!.isNotEmpty) {
          mUsers.addAll(value.users!);
        } else {
          hasNextPage.value = false;
        }
      } catch (err) {
        debugPrint('Something went wrong!');
      }

      isLoadMoreRunning.value = false;
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
//    seperateUsers();
    log('----length--fgbg--${invitedUsers.length}');
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  /*void seperateUsers() {
    for (int i = 0; i < widget.selectedUsers.toList().length; i++) {
      if (widget.selectedUsers[i].id == null) {
        invitedUsers.add(widget.selectedUsers[i]);
      }
    }
  }*/

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        height: MediaQuery.of(context).size.height * .90,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: AppColors.grey),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Center(
                        child: Text(
                      'newGroup'.tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 17,
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: CustomTextEditingController(
                    controller: _nameController,
                    hintText: 'groupName'.tr,
                    label: 'groupName'.tr,
                    labelEnabled: true,
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    minLines: 1,
                    isFontSize: true,
                    showWrapper: true,
                    focusNode: nameFocusNode,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: CustomTextEditingController(
                //           hintText: 'search'.tr,
                //           focusNode: searchFocusNode,
                //           maxLines: 1,
                //           label: 'search'.tr,
                //           labelEnabled: true,
                //           outsideLabelEnabled: true,
                //           controller: searchEditingController,
                //           textCapitalization: TextCapitalization.sentences,
                //         ),
                //       ),
                //       IconButton(
                //         icon: Icon(
                //           Icons.search_rounded,
                //           color: AppColors.darkPrimaryColor,
                //           size: 25,
                //         ),
                //         onPressed: () async {
                //           currentPageNumber = 1;
                //           isFirstLoadRunning.value = true;
                //           AllUsersResponse? value = await authApi.fetchAllUsers(
                //               pageNumber: currentPageNumber,
                //               keyword: searchKeyword);
                //           if (value != null &&
                //               value.users != null &&
                //               value.users!.isNotEmpty) {
                //             mUsers.value = value.users!;
                //           } else {
                //             mUsers.value = [];
                //           }
                //           if (searchEditingController.value.text.isEmpty) {
                //             mUsers.insertAll(0, invitedUsers);
                //           }
                //           isFirstLoadRunning.value = false;
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.brightGrey.withAlpha(90),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      child: CupertinoSearchTextField(
                        controller: searchEditingController,
                        onChanged: (searchData) async {
                          currentPageNumber = 1;
                          AllUsersResponse? value = await authApi.fetchAllUsers(
                              pageNumber: currentPageNumber,
                              keyword: searchKeyword);
                          if (value != null &&
                              value.users != null &&
                              value.users!.isNotEmpty) {
                            mUsers.value = value.users!;
                          } else {
                            mUsers.value = [];
                          }
                          if (searchEditingController.text.isEmpty) {
                            mUsers.insertAll(0, invitedUsers);
                          }
                        },
                        onSubmitted: (searchData) async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          currentPageNumber = 1;
                          isFirstLoadRunning.value = true;
                          AllUsersResponse? value = await authApi.fetchAllUsers(
                              pageNumber: currentPageNumber,
                              keyword: searchKeyword);
                          if (value != null &&
                              value.users != null &&
                              value.users!.isNotEmpty) {
                            mUsers.value = value.users!;
                          } else {
                            mUsers.value = [];
                          }
                          if (searchEditingController.text.isEmpty) {
                            mUsers.insertAll(0, invitedUsers);
                          }
                          isFirstLoadRunning.value = false;
                        },
                        onSuffixTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          searchEditingController.text = "";
                          mUsers.value = [];
                          invitedUsers.value = [];
                          isFirstLoadRunning.value = true;
                          AllUsersResponse? value = await authApi.fetchAllUsers(
                              pageNumber: currentPageNumber, keyword: "");

                          if (value != null &&
                              value.users != null &&
                              value.users!.isNotEmpty) {
                            mUsers.addAll(value.users!);
                          }
                          isFirstLoadRunning.value = false;
                          setState(() {});
                        },
                        decoration: BoxDecoration(
                            color: AppColors.brightGrey,
                            backgroundBlendMode: BlendMode.dstATop),
                        autofocus: false,
                        placeholder: "Search",
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() => (isFirstLoadRunning.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                controller: _controller,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    (mUsers.length /*+ invitedUsers.length*/),
                                itemBuilder: (_, index) {
                                  UserModel userData =
                                      mUsers.value.elementAt(index);
                                  if (userData.id ==
                                      FirebaseAuth.instance.currentUser?.uid) {
                                    return const SizedBox();
                                  }
                                  if (userData.id == null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        title: Text(userData.name ?? 'name'),
                                        leading: UserProfileWidget(
                                          showOwnProfile: true,
                                          userModel: userData,
                                        ),
                                        trailing: Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          value:
                                              selectedUsers.contains(userData),
                                          onChanged: (bool? isChecked) {
                                            if (isChecked != null) {
                                              setState(() {
                                                if (userData.email != null) {
                                                  if (isChecked) {
                                                    selectedUsers.add(userData);
                                                    // mUsers[index].isChecked = true;
                                                  } else {
                                                    selectedUsers
                                                        .remove(userData);
                                                    // mUsers[index].isChecked = false;
                                                  }
                                                }
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return /*index < (invitedUser.length ).toInt()  ? */ Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(userData.name ?? 'name'),
                                      leading: UserProfileWidget(
                                        showOwnProfile: true,
                                        userModel: userData,
                                      ),
                                      trailing: Checkbox(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        value: selectedUsers.contains(userData),
                                        onChanged: (bool? isChecked) {
                                          if (isChecked != null) {
                                            setState(() {
                                              if (userData.email != null) {
                                                if (isChecked) {
                                                  selectedUsers.add(userData);
                                                  // mUsers[index].isChecked = true;
                                                } else {
                                                  selectedUsers
                                                      .remove(userData);
                                                  // mUsers[index].isChecked = false;
                                                }
                                              }
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context,
                                        int index) =>
                                    Divider(
                                        endIndent: 0,
                                        indent: 0,
                                        color: AppColors.textFieldBorderColor),
                              ),
                            ),
                            Visibility(
                              visible: isLoadMoreRunning.value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  height: 60,
                  child: CustomButton(
                    title: 'createGroup'.tr,
                    onPressed: () async {
                      //print(selectedUsers.length);
                      if (_nameController.text.trim().isNotEmpty) {
                        if (selectedUsers.length > 1) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });
                          await createGroup(
                                  selectedUsers, _nameController.text.trim())
                              .then((value) {
                            selectedUsers.clear();
                            _nameController.clear();
                            setState(() {
                              isLoading = false;
                            });
                            showInSnackBar(
                              'Created successfully',
                              isSuccess: true,
                            );
                            Navigator.of(context).pop();
                          });
                        } else {
                          showInSnackBar('Please select two or more hoomans',
                              isSuccess: false);
                        }
                      } else {
                        showInSnackBar('Please enter group name',
                            isSuccess: false);
                      }
                    },
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> createGroup(RxList<UserModel> list, String groupName) {
    List<ChatUserModel> userList = [];
    userList.add(ChatUserModel(
      userId: FirebaseAuth.instance.currentUser!.uid,
      profileImage: FirebaseAuth.instance.currentUser!.photoURL ?? staticImage,
      numberOfUnreadMessages: 0,
      name: FirebaseAuth.instance.currentUser!.displayName ?? "Name",
    ));
    userList.addAll(list
        .map((element) => ChatUserModel(
            userId: element.id ?? '',
            name: element.name ?? "Name",
            numberOfUnreadMessages: 0,
            profileImage: element.profilePicture ?? staticImage))
        .toList());
    return ConversationsBloc.createConversation(userList, groupName: groupName);
  }
}

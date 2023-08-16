import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medzo/model/user_model.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';
import 'package:medzo/utils/app_storage.dart';
import 'package:shimmer/shimmer.dart';

class UserProfileWidget extends StatefulWidget {
  final UserModel? userModel;
  final bool showOwnProfile;
  final Size? size;

  final bool? showProgressIndicator;

  const UserProfileWidget(
      {Key? key,
      this.userModel,
      this.size,
      this.showOwnProfile = true,
      this.showProgressIndicator})
      : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  UserModel? userData;
  Size size = const Size(35, 35);

  late bool showProgressIndicator;

  @override
  void initState() {
    super.initState();
    size = widget.size ?? size;
    showProgressIndicator = widget.showProgressIndicator ?? true;
    if (widget.userModel != null) {
      userData = widget.userModel;
    } else {
      if (widget.showOwnProfile) {
        final value = AppStorage().getUserData();
        if (value != null) {
          userData = value;
          log("$userData", name: "else init profilepic");
        } else {
          log("$userData", name: "else init else part profilepic");

          userData = null;
        }
      }
    }
  }

  @override
  void didUpdateWidget(UserProfileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userModel != null && userData != null) {
      userData = widget.userModel!;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;
    if (userData == null) {
      widget = Container(
        height: size.height * 1.5,
        width: size.width * 1.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: noUserBuilder,
      );
    } else {
      if (userData != null &&
          userData!.profilePicture != null &&
          userData!.profilePicture != "" &&
          (userData!.profilePicture.toString() != 'null' ||
              userData!.profilePicture.toString().isNotEmpty)) {
        widget = Container(
          height: size.height * 1.5,
          width: size.width * 1.5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(50)),
          child: Image.network(
            userData!.profilePicture!,
            fit: BoxFit.cover,
            loadingBuilder: !showProgressIndicator
                ? null
                : (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.white,
                        child: Container(
                            height: size.height,
                            width: size.width,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.person_outline,
                              color: AppColors.primaryColor,
                              size: size.height,
                            )),
                      ),
                    );
                  },
            errorBuilder: (_, __, ___) {
              return noUserBuilder;
            },
            // errorWidget: (_, __, ___) {
            //   return noUserBuilder;
            // },
            height: size.height,
            width: size.width,
          ),
        );
      } else {
        widget = (userData?.name != null && userData!.name!.isNotEmpty)
            ? Text(
                userData!.name![0].toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.primaryColor,fontSize: 20,fontFamily: AppFont.fontBold),
              )
            : noUserBuilder;
      }
    }

    return CircleAvatar(
      radius: 28,
      backgroundColor: Colors.white,
      child: widget,
    );
  }

  Container get noUserBuilder {
    return Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.person_outline,
          color: AppColors.primaryColor,
          size: size.height,
        ));
  }
}

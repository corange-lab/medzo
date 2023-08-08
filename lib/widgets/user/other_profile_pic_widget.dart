import 'package:flutter/material.dart';
import 'package:medzo/chat/view/widget/widget.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';

class OtherProfilePicWidget extends StatelessWidget {
  final Size? size;
  final String? profilePictureUrl;
  const OtherProfilePicWidget({this.size, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.height ?? 40,
      width: size?.width ?? 40,
      child: ClipOval(
        child: CircularProfileAvatar(
          profilePictureUrl ?? '',
          cacheImage: true,
          animateFromOldImageOnUrlChange: true,
          placeHolder: (context, url) => Container(
            color: AppColors.grey.withOpacity(0.3),
            child: Center(
              child: Text("MEDZO",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.white,
                      fontFamily: AppFont.fontFamilysemi,
                      fontWeight: FontWeight.w500,
                      fontSize: 8)),
            ),
          ),
          radius: 24,
          errorWidget: (context, url, error) =>
              Icon(Icons.error, color: AppColors.primaryColor),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
    );
  }
}

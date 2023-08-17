import 'package:flutter/material.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/widgets/custom_widget.dart';

class MyChatWidget extends Container {
  final String message;
  final String time;
  final bool sender;

  MyChatWidget(this.message, this.time, this.sender);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // sender ? SizedBox() : CircularProfileAvatar(SvgIcon.profile,backgroundColor: AppColors.primaryColor,radius: 15),

        Container(
          margin: const EdgeInsets.only(
            right: 10,
            left: 10,
            bottom: 5,
          ),
          height: 42,
          decoration: BoxDecoration(
              color: sender ? AppColors.primaryColor : AppColors.splashdetail,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                  topRight: Radius.circular(6))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextWidget(message,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: sender ? AppColors.black : AppColors.chatblack,
                          fontSize: 14)),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: TextWidget(time,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: sender ? AppColors.darkyellow : AppColors.grey,
                          fontSize: 10)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

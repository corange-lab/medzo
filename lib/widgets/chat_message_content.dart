import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/widgets/custom_widget.dart';

class MyChatWidget extends Container {
  final String message;
  final String time;
  final bool sender;
  final bool isFirstMessage;

  MyChatWidget(this.message, this.time, this.sender, this.isFirstMessage);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // sender ? SizedBox() : CircularProfileAvatar(SvgIcon.profile,backgroundColor: AppColors.primaryColor,radius: 15),

        ChatBubble(
          clipper: ChatBubbleClipper1(
              type: sender ? BubbleType.sendBubble : BubbleType.receiverBubble),
          padding: isFirstMessage
              ? EdgeInsets.only(left: sender ? 0 : 12, right: sender ? 12 : 0)
              : EdgeInsets.zero,
          margin: isFirstMessage
              ? EdgeInsets.only(bottom: 5)
              : EdgeInsets.only(
                  left: sender ? 0 : 12, right: sender ? 12 : 0, bottom: 5),
          backGroundColor:
              sender ? AppColors.primaryColor : AppColors.splashdetail,
          shadowColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: sender ? AppColors.primaryColor : AppColors.splashdetail,
                borderRadius: isFirstMessage
                    ? sender
                        ? BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                            topRight: Radius.circular(0))
                        : BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                            bottomLeft: Radius.circular(6))
                    : BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 2, top: 5, right: 5),
                        child: TextWidget(message,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: sender
                                        ? AppColors.black
                                        : AppColors.chatblack,
                                    fontSize: 13,
                                    height: 1.2)),
                      ),
                    ),
                    SizedBox(
                      width: 45,
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 7, bottom: 5, right: 7),
                    child: TextWidget(time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color:
                                sender ? AppColors.darkyellow : AppColors.grey,
                            fontSize: 10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

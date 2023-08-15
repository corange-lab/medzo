import 'package:flutter/material.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/widgets/custom_widget.dart';

class MyChatWidget extends Container {
  final String myMessage;
  final String time;

  MyChatWidget(this.myMessage, this.time);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10, left: 5, bottom: 2, top: 3),
          height: 45,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
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
                  child: TextWidget(myMessage,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.black, fontSize: 14)),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: TextWidget(time,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.darkyellow, fontSize: 10)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

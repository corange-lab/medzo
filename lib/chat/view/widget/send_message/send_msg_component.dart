part of '../widget.dart';

class SendMessageComponent extends StatelessWidget {
  const SendMessageComponent({
    Key? key,
    required this.textController,
    required this.onSend,
    required this.onSendImage,
  }) : super(key: key);

  // Text editing controller for msg send
  final TextEditingController textController;
  final void Function() onSend;
  final void Function() onSendImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: Row(
        children: [
          SendMessageIconWidget(
            iconWidget: const Image(
              image: AssetImage(AppImages.gallaryIcon),
            ),
            onSend: onSendImage,
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon:
          //   color: const Color(0xff849396),
          // ),
          Flexible(
            child: SendMSGTextBoxWidget(
              textController: textController,
              onSend: onSend,
            ),
          )
        ],
      ),
    );
  }
}

part of '../widget.dart';

class ShowTimeComponent extends StatelessWidget {
  const ShowTimeComponent({
    Key? key,
    required this.message,
    required this.isCurrentUser,
    required this.privMessage,
    required this.profileImage,
    required this.isLastMessage,
    required this.chatBubbleStyle,
    this.isFirstMessage = false,
  }) : super(key: key);
  final String profileImage;
  final MessageModel message;
  final MessageModel privMessage;
  final bool isCurrentUser;
  final bool isLastMessage;
  final ChatBubbleCornerStyle chatBubbleStyle;
  final bool isFirstMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLastMessage)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              message.createdTime.chatDateTime(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.graniteGray,
              ),
            ),
          ),
        ChatBubble(
          isFirstMessage: isFirstMessage,
          text: message.content ?? message.imageUrl!,
          isCurrentUser: isCurrentUser,
          isLastMessage: isLastMessage,
          chatBubbleStyle: chatBubbleStyle,
          profileImage: profileImage,
          isImage: message.isImage,
        ),
        if (!isLastMessage)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              privMessage.createdTime.chatDateTime(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.graniteGray,
              ),
            ),
          ),
      ],
    );
  }
}

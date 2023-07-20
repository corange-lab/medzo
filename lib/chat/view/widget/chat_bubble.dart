// ignore_for_file: public_member_api_docs, sort_constructors_first
part of './widget.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.text,
    required this.profileImage,
    required this.isCurrentUser,
    required this.isLastMessage,
    required this.isImage,
    required this.chatBubbleStyle,
    this.isFirstMessage = false,
  }) : super(key: key);
  final String text;
  final String profileImage;
  final bool isCurrentUser;
  final bool isLastMessage;
  final bool isFirstMessage;
  final bool isImage;
  final ChatBubbleCornerStyle chatBubbleStyle;

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
    /* Padding(
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? MediaQuery.of(context).size.width * 0.10 : 0,
        0,
        isCurrentUser ? 0 : MediaQuery.of(context).size.width * 0.10,
        0,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser
                ? const Color(0xff09262D)
                : const Color(0xffF8FAFA),
            // borderRadius: isCurrentUser
            //     ? const BorderRadius.only(
            //         topRight: Radius.circular(12),
            //         topLeft: Radius.circular(12),
            //         bottomLeft: Radius.circular(12),
            //         bottomRight: Radius.circular(5),
            //       )
            //     : const BorderRadius.only(
            //         topRight: Radius.circular(12),
            //         topLeft: Radius.circular(12),
            //         bottomLeft: Radius.circular(5),
            //         bottomRight: Radius.circular(12),
            //       ),

            borderRadius: isCurrentUser
                ? const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(5),
                  )
                : */ /*ChatBubbleCornerStyle.topRightSide == chatBubbleStyle
                    ? const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )
                    : */ /*
                const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(12),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: isCurrentUser ? Colors.white : Colors.black87),
              textAlign: isCurrentUser ? TextAlign.right : TextAlign.left,
            ),
          ),
        ),
      ),
    );*/
  }

  Widget buildItem(BuildContext context) {
    if (isCurrentUser) {
      // Right (my message)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          !isImage
              // Text
              ? Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  decoration: BoxDecoration(
                      color: AppColors.darkBlue,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(3),
                      )),
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100),
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Color(0xffF8FAFA),
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
                  ),
                )
              :
              // Image
              Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullPhotoPage(
                                  url: messageChat.content,
                                ),
                              ),
                            );*/
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.all(0))),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        text,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            width: 200,
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return Material(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              'images/img_not_available.jpeg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
        ],
      );
    } else {
      // Left (peer message)
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                isFirstMessage
                    ? SizedBox(
                        width: 35,
                        height: 35,
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                            profileImage,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return const Icon(
                                Icons.account_circle,
                                size: 35,
                                color: Colors.grey,
                              );
                            },
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(width: 35),
                !isImage
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(3),
                              bottomRight: Radius.circular(12),
                            )),
                        margin: const EdgeInsets.only(left: 10),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width - 100),
                        child: Text(
                          text,
                          style: const TextStyle(
                              color: Color(0xff09262D),
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: TextButton(
                          onPressed: () {
                            /* Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullPhotoPage(url: messageChat.content),
                          ),
                        );*/
                          },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(0))),
                          child: Material(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              text,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stackTrace) =>
                                  Material(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'images/img_not_available.jpeg',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      );
    }
  }
}

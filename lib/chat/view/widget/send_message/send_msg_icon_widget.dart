
part of '../widget.dart';


class SendMessageIconWidget extends StatelessWidget {
  const SendMessageIconWidget(
      {Key? key, required this.onSend, required this.iconWidget})
      : super(key: key);
  final void Function() onSend;
  final Widget iconWidget;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onSend,
      icon: iconWidget,
      splashRadius: 1,
    );
  }
}

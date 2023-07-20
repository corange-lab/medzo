part of '../widget.dart';

class SendMSGTextBoxWidget extends StatelessWidget {
  const SendMSGTextBoxWidget(
      {Key? key, required this.textController, required this.onSend})
      : super(key: key);
  final TextEditingController textController;
  final void Function() onSend;

  @override
  Widget build(BuildContext context) {
    return TextField(
      // cursorHeight: 30,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: AppColors.darkPrimaryColor,
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      controller: textController,
      //  style: TextStyle(fontSize: 17.0, height: 0.20),
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        hintText: "Aa", //'message'.tr,
        hintStyle: TextStyle(color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          gapPadding: 0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          gapPadding: 0,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          gapPadding: 0,
        ),
        fillColor: AppColors.white,
        filled: true,
        suffixIcon: SendMessageIconWidget(
          iconWidget: Container(
            padding: const EdgeInsets.all(2.7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor,
            ),
            child: Icon(
              Icons.arrow_upward,
              size: 20,
              color: AppColors.darkPrimaryColor,
            ),
          ),
          onSend: onSend,
        ),
      ),
      maxLines: 4,
      minLines: 1,
    );
  }
}

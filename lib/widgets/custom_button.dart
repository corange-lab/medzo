import 'package:flutter/material.dart';
import 'package:medzo/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final bool enabled;
  final void Function()? onPressed;
  final String title;
  final Color? backgroundButtonColor;
  final Widget? prefixIcon;
  final bool showProgress;

  const CustomButton({
    Key? key,
    this.enabled = true,
    this.showProgress = true,
    this.onPressed,
    required this.title,
    this.backgroundButtonColor,
    this.prefixIcon,
  }) : super(key: key);

  CustomButton.light({
    Key? key,
    bool? enabled,
    Function()? onPressed,
    required String title,
    Widget? prefixIcon,
    bool? showProgress = true,
  })  : enabled = enabled ?? true,
        showProgress = showProgress ?? true,
        onPressed = onPressed,
        title = title,
        prefixIcon = prefixIcon,
        backgroundButtonColor = AppColors.lightSky,
        super(key: key);

  // const CustomButton.light({
  //   Key? key,
  //   this.enabled = true,
  //   this.showProgress = true,
  //   this.onPressed,
  //   required this.title,
  //   this.backgroundButtonColor = const Color(0xffE8F5F5),
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width / 1.1,
      color: Colors.transparent,
      height: 54,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(13)),
              foregroundColor: MaterialStateProperty.all<Color>(
                  enabled ? AppColors.primaryColor : AppColors.lightGrey),
              backgroundColor: MaterialStateProperty.all<Color>(
                  backgroundButtonColor ??
                      (enabled
                          ? AppColors.primaryColor
                          : AppColors.lightButtonBackground)),
              overlayColor:
                  MaterialStateProperty.all<Color>(AppColors.primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
          child:
              // enabled
              //     ?
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixIcon ?? Container(),
              Center(
                child: SizedBox(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: enabled
                            ? AppColors.darkPrimaryColor
                            : AppColors.lightGrey),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 10,
                  ),
                ),
              )
            ],
          )
          // : showProgress
          //     ? Padding(
          //         padding: const EdgeInsets.all(8),
          //         child: CircularProgressIndicator(
          //             valueColor: AlwaysStoppedAnimation<Color>(
          //                 (backgroundButtonColor == AppColors.lightSky)
          //                     ? Theme.of(context).primaryColor
          //                     : AppColors.white)),
          //       )
          //     : const SizedBox(),
          ),
    );
  }
}

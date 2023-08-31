import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:medzo/theme/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final bool enabled;
  final void Function()? onPressed;
  final String title;
  final Color? backgroundButtonColor;
  final Widget? prefixIcon;
  final bool showProgress;
  final double? padding;
  final double? radius;

  const CustomButtonWidget(
      {Key? key,
      this.enabled = true,
      this.showProgress = true,
      this.onPressed,
      required this.title,
      this.backgroundButtonColor,
      this.prefixIcon,
      this.padding,
      this.radius})
      : super(key: key);

  CustomButtonWidget.light(
      {Key? key,
      bool? enabled,
      Function()? onPressed,
      required String title,
      Widget? prefixIcon,
      bool? showProgress = true,
      double? padding = 10.0,
      double? radius = 10.0})
      : enabled = enabled ?? true,
        showProgress = showProgress ?? true,
        onPressed = onPressed,
        title = title,
        prefixIcon = prefixIcon,
        backgroundButtonColor = AppColors.lightSky,
        padding = padding,
        radius = radius,
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
        onPressed: enabled ? onPressed : null,
        style: ButtonStyle(
            splashFactory: NoSplash.splashFactory,
            elevation: MaterialStateProperty.all(0),
            padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.all(padding ?? 8.0)),
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColors.primaryColor),
            backgroundColor: MaterialStateProperty.all<Color>(
                backgroundButtonColor ?? AppColors.primaryColor),
            overlayColor: MaterialStateProperty.all<Color>(
                AppColors.textFieldBorderColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 12.0),
            ))),
        child: enabled
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  prefixIcon ?? Container(),
                  Center(
                    child: SizedBox(
                      child: Text(
                        '${title}'.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.darkPrimaryColor),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                      ),
                    ),
                  )
                ],
              )
            : showProgress
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            (backgroundButtonColor == AppColors.lightSky)
                                ? Theme.of(context).primaryColor
                                : AppColors.white)),
                  )
                : const SizedBox(),
      ),
    );
  }
}

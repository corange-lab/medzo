import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medzo/theme/colors.dart';
import 'package:medzo/utils/app_font.dart';

class CustomTextEditingController extends StatefulWidget {
  final TextEditingController controller;
  final Function()? onTap;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? enabled;
  final bool? readOnly;
  final InputDecoration? decoration;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final int? minLines;
  final void Function()? onSuffixTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? label;
  final TextStyle? style;
  final TextCapitalization? textCapitalization;
  final bool? obscureText;
  final bool? labelEnabled;
  final bool outsideLabelEnabled;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isAboutTextField;
  final bool? filled;
  final bool? showWrapper;
  final bool? isFontSize;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextEditingController(
      {Key? key,
      required this.controller,
      this.isAboutTextField = false,
      this.onTap,
      this.maxLines,
      this.keyboardType,
      this.autofocus,
      this.enabled,
      this.readOnly,
      this.decoration,
      this.validator,
      this.focusNode,
      this.minLines,
      this.onChanged,
      this.onFieldSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.onSuffixTap,
      this.hintText,
      this.label,
      this.style,
      this.textCapitalization,
      this.obscureText,
      this.labelEnabled,
      this.outsideLabelEnabled = true,
      this.maxLength,
      this.inputFormatters,
      this.filled,
      this.showWrapper,
      this.fillColor,
      this.isFontSize,
      this.textInputAction,
      this.contentPadding})
      : super(key: key);

  @override
  State<CustomTextEditingController> createState() =>
      _CustomTextEditingControllerState();
}

class _CustomTextEditingControllerState
    extends State<CustomTextEditingController> {
  @override
  Widget build(BuildContext context) {
    //   if (widget.focusNode == null || widget.label == null) {
    //     return Container(
    //       child: buildTextFormField(context),
    //     );
    //   } else {
    //     return TextFieldWrapper(
    //       focusNode: widget.focusNode!,
    //       label: widget.label,
    //       customLabel: widget.label,
    //       outsideLabelEnabled: widget.outsideLabelEnabled,
    //       child: buildTextFormField(context),
    //     );
    //   }
    return Padding(
      padding: widget.showWrapper == false
          ? const EdgeInsets.all(0)
          : const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: buildTextFormField(context),
    );
  }

  Widget buildTextFormField(BuildContext context) {
    return Container(
      // height: widget.isAboutTextField ? null : 60,
      decoration: widget.showWrapper == false
          ? null
          : BoxDecoration(
              border:
                  Border.all(color: AppColors.textFieldBorderColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
      padding:
          widget.showWrapper == false ? null : const EdgeInsets.only(left: 15),
      child: TextFormField(
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        onTap: widget.onTap,
        // maxLines: getMaxLines(),
        maxLines: widget.maxLines,
        autofillHints: getAutofillHints(),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        autocorrect: false,
        autofocus: widget.autofocus ?? false,
        enabled: widget.enabled ?? true,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
        obscureText: widget.obscureText ?? false,
        decoration: getDecoration(context),
        validator: widget.validator,
        cursorColor: Colors.black,
        readOnly: widget.readOnly ?? false,
        focusNode: widget.focusNode,
        minLines: widget.minLines ?? 1,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        maxLength: widget.maxLength,
      ),
    );
  }

  int? getMaxLines() {
    if (widget.obscureText != null && widget.obscureText!) {
      return 1;
    }
    return ((widget.maxLines == null) ||
            (widget.minLines == null) ||
            (widget.maxLines! >= widget.minLines!))
        ? null
        : 1;
  }

  InputDecoration getDecoration(BuildContext context) {
    if (widget.decoration != null) {
      return widget.decoration!.copyWith(
        contentPadding: const EdgeInsets.only(left: 5),
        counterText: '',
      );
    } else {
      return InputDecoration(
          filled: widget.filled,
          focusColor: Colors.white,
          prefixIcon: widget.prefixIcon,
          prefixIconConstraints:
              const BoxConstraints.expand(height: 16, width: 30),
          suffixIcon: getSuffixIcon(),
          /*border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),*/
          enabledBorder: widget.showWrapper == false
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                )
              : InputBorder.none,
          focusedBorder: widget.showWrapper == false
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                )
              : InputBorder.none,
          disabledBorder: widget.showWrapper == false
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                )
              : InputBorder.none,
          fillColor: widget.fillColor ?? Colors.grey,
          hintText: widget.hintText,
          counterText: '',
          hintStyle: widget.style ??
              TextStyle(
                color: AppColors.graniteGray,
                fontSize: 16,
                fontFamily: AppFont.fontFamily,
                fontWeight: FontWeight.w400,
              ),
          labelText:
              (widget.labelEnabled != null && widget.labelEnabled == true)
                  ? widget.label //'Enter ${widget.hintText ?? 'value'}'
                  : null,
          labelStyle: widget.style ??
              Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: AppColors.graniteGray,
                  ),
          contentPadding: widget.contentPadding);
    }
  }

  Widget? getSuffixIcon() {
    Widget? mWidget;
    if (widget.suffixIcon != null) {
      mWidget = InkWell(
        onTap: widget.onSuffixTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          height: 6,
          width: 6,
          child: widget.suffixIcon!,
        ),
      );
    }
    return mWidget;
  }

  List<String> getAutofillHints() {
    List<String> autofillHints = [];
    if (widget.keyboardType != null) {
      if (widget.keyboardType == TextInputType.emailAddress) {
        autofillHints.add(AutofillHints.email);
      }
      if (widget.keyboardType == TextInputType.streetAddress) {
        autofillHints.add(AutofillHints.fullStreetAddress);
      }
      if (widget.keyboardType == TextInputType.phone) {
        autofillHints.add(AutofillHints.telephoneNumber);
      }
      if (widget.keyboardType == TextInputType.name) {
        autofillHints.add(AutofillHints.name);
      }

      return autofillHints;
    } else {
      return autofillHints;
    }
  }
}

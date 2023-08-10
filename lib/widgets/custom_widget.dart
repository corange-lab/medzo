import 'package:flutter/material.dart';

class TextWidget extends Text {
  final String text;
  final TextStyle? style;
  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final int? maxLine;
  final TextDecoration? decoration;

  TextWidget(this.text,
      {this.style,
      this.textOverflow,
      this.textAlign = TextAlign.center,
      this.maxLine,
      this.decoration})
      : super('');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      text,
      style: style,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}

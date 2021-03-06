import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';

class ZCText extends StatelessWidget {
  ZCText(
      {this.text,
      this.fontSize = kFontSize,
      this.bold = false,
      this.semiBold = false,
      this.maxLines,
      this.underline = false,
      this.textAlign,
      this.overflow = TextOverflow.ellipsis,
      this.color = Constants.zc_font_black});

  final String text;
  final double fontSize;
  final bool bold;
  final bool semiBold;
  final int maxLines;
  final bool underline;
  final TextAlign textAlign;
  final Color color;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text == null ? " " : text,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: false,
      style: new TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: semiBold
              ? FontWeight.w600
              : bold ? FontWeight.w800 : FontWeight.normal,
          decoration: underline ? TextDecoration.underline : null,
          fontFamily: Constants.segoe_font,
          ),
      textAlign: textAlign,
    );
  }
}

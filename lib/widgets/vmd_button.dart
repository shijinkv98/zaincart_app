import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';

class VMDButton extends StatelessWidget {
  VMDButton(
      {this.title = "VMDButton",
      this.onPressed,
      this.width,
      this.height = 50.0,
      this.fontSize = kFontSize,
      this.border = false,
      this.color = Colors.deepOrangeAccent,
      this.isDisabled = false,
      this.titleColor = Colors.white});
  final String title;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double fontSize;
  final bool border;
  final Color color;
  final Color titleColor;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: height,
      width: width,
      child: new RaisedButton(
        onPressed: isDisabled ? null : onPressed,
        color: color,
        elevation: 0.0,
        shape: border
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0),
                side: BorderSide(color: titleColor))
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        child: new Center(
          child: new Text(
            title,
            style: new TextStyle(
                color: titleColor,
                fontFamily: Constants.segoe_font,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.85),
          ),
        ),
      ),
    );
  }
}

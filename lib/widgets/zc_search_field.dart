import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';

class ZCSearchField extends StatelessWidget {
  ZCSearchField(
      {this.hintText,
      this.height = 47.0,
      this.width,
      this.validator,
      this.emptyValidator = false,
      this.emptyValidatorMsg = "Should not be empty",
      this.textInputType,
      this.maxLength,
      this.controller,
      this.onSearchTap,
      this.onChanged,
      this.obscureText = false});

  final String hintText;
  final double height;
  final double width;
  final TextEditingController controller;
  final Function validator;
  final bool emptyValidator;
  final String emptyValidatorMsg;
  final TextInputType textInputType;
  final int maxLength;
  final bool obscureText;
  final void Function(String) onSearchTap;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child: TextField(
          maxLines: 1,
          maxLength: maxLength,
          controller: controller,
          keyboardType: textInputType,
          onSubmitted: (value) => onSearchTap(controller.text),
          onChanged: (value) => onChanged(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: EdgeInsets.only(top: 13.0, left: 10.0),
            hintStyle: new TextStyle(
                color: Colors.grey,
                fontSize: kFontSize,
                fontWeight: FontWeight.normal,
                fontFamily: Constants.segoe_font,
                letterSpacing: 0.85),
            prefixIcon: InkWell(
              child: Icon(
                Icons.search,
                size: 30.0,
              ),
              onTap: () => onSearchTap(controller.text),
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCTextFormField extends StatelessWidget {
  ZCTextFormField(
      {this.hintText,
      this.subHint,
      this.controller,
      this.validator,
      this.emptyValidator = false,
      this.emptyValidatorMsg = "Required",
      this.textInputType,
      this.maxLength,
      this.obscureText = false,
      this.textInputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.textCapitalization = TextCapitalization.none,
      this.enabled = true,
      this.onChanged});

  final String hintText;
  final String subHint;
  final TextEditingController controller;
  final Function validator;
  final bool emptyValidator;
  final String emptyValidatorMsg;
  final TextInputType textInputType;
  final int maxLength;
  final bool obscureText;
  final TextInputAction textInputAction;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final ValueChanged<String> onChanged;

  var showSubHint = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    showSubHint.value = controller.text.isEmpty ? true : false;
    return Stack(
      children: <Widget>[
        TextFormField(
          obscureText: obscureText,
          enabled: enabled,
          autocorrect: textInputType == TextInputType.emailAddress ?? false,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          textCapitalization: textCapitalization,
          keyboardType: textInputType,
          focusNode: focusNode,
          maxLength: maxLength,
          maxLines: null,
          onChanged: (text) {
            showSubHint.value = text.isEmpty ? true : false;
            if (onChanged != null) {
              onChanged(text);
            }
          },
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.only(left: 10.0),
              enabledBorder: new UnderlineInputBorder(
                  borderSide: new BorderSide(
                      color: Constants.zc_font_grey, width: 1.0)),
              hintStyle: TextStyle(
                  fontFamily: Constants.segoe_font,
                  fontSize: kFieldFontSize,
                  letterSpacing: 0.85)),
          controller: controller,
          validator: emptyValidator ? _validateField : validator,
        ),
        ValueListenableBuilder(
            valueListenable: showSubHint,
            builder: (context, value, child) => value
                ? Positioned(
                    top: 14.0,
                    left: _textSize(
                                hintText,
                                TextStyle(
                                    fontFamily: Constants.segoe_font,
                                    fontSize: kFieldFontSize,
                                    letterSpacing: 0.85))
                            .width +
                        20,
                    child: ZCText(
                      text: subHint,
                      color: Constants.zc_font_light_grey,
                      fontSize: kFontSize,
                    ))
                : new Container())
      ],
    );
  }

  String _validateField(String text) {
    if (text.length == 0) {
      return emptyValidatorMsg;
    } else {
      return null;
    }
  }

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}

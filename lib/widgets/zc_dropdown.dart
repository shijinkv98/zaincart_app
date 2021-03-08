import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCDropdown extends StatelessWidget {
  ZCDropdown(
      {this.hintText,
      this.subHint,
      this.items,
      this.onChanged,
      this.selectedValue,
      this.displayItem,
      this.searchFn});

  final String hintText;
  final String subHint;
  final String selectedValue;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final Function displayItem;
  final Function searchFn;

  bool showSubHint = true;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return new DropdownButtonFormField<String>(
        iconSize: 30.0,
        isExpanded: true,
        hint: Container(
          child: new Row(
            children: [
              new ZCText(
                text: hintText,
                bold: false,
                semiBold: false,
                fontSize: kFieldFontSize,
              ),
              subHint != null
                  ? ZCText(
                      text: " $subHint",
                      color: Constants.zc_font_grey,
                      fontSize: kFontSize,
                    )
                  : Container()
            ],
          ),
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Constants.zc_font_grey, width: 1.0))),
        items: items.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new ZCText(
              text: value.trim(),
              color: Colors.black,
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            this.showSubHint = false;
          });
          onChanged(value);
        },
        value: selectedValue,
      );
    });
  }

  String _validateField(String text) {
    if (text == null) {
      return "Please select an item";
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';

class ZCSearchField extends StatelessWidget {
  ZCSearchField(
      {this.hintText,
      this.selectedItem,
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
      this.onCategorySelected,
      this.focusNode,
      this.readOnly,
      this.items});

  final String hintText;
  final String selectedItem;
  final double height;
  final double width;
  final TextEditingController controller;
  final Function validator;
  final bool emptyValidator;
  final String emptyValidatorMsg;
  final TextInputType textInputType;
  final int maxLength;
  final List<String> items;
  final void Function(String) onSearchTap;
  final void Function(String) onChanged;
  final void Function(String) onCategorySelected;
  final FocusNode focusNode;
  final bool readOnly;

  var selectedValue = ValueNotifier("Category");

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
      height: height,
      child: Row(
        children: [
          Container(
            width: 160.0,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: ValueListenableBuilder(
                valueListenable: selectedValue,
                builder: (context, selected, child) =>
                    DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: selectedItem != null ? selectedItem : selected,
                        items: items.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedValue.value = value;
                          onCategorySelected(value);
                        },
                      ),
                    )),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: TextField(
                  maxLines: 1,
                  maxLength: maxLength,
                  controller: controller,
                  keyboardType: textInputType,
                  readOnly: readOnly,
                  focusNode: focusNode,
                  onTap: readOnly ? () => onSearchTap("") : null,
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
                        size: 20.0,
                      ),
                      onTap: () => onSearchTap(controller.text),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

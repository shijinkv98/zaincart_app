import 'package:flutter/material.dart';

class Constants {
  //font
  static const segoe_font = 'Segoe';
  //asset images
  static const bg_diamonds = 'assets/bg_diamonds.png';


  //colors..

  static const vmd_green = const Color(0xFF00A99D);
  static const vmd_diamond_green = const Color(0xFFB0BF7A);
  static const vmd_bg_grey = const Color(0xFFF8F8F8);
  static const vmd_bg_green = Color.fromRGBO(0, 169, 157, 0.25);
  static const vmd_font_grey = const Color(0xFF707070);
  static const vmd_button_text_grey = const Color(0xFF8B919D);
  static const vmd_dialog_font_grey = const Color(0xFFA3A8A8);
  static const vmd_divider_grey = const Color(0xFFDDDDDD);
  static const vmd_font_light_grey = const Color.fromRGBO(139, 145, 157, 0.6);
  static const vmd_shadow = Color.fromRGBO(38, 41, 55, 0.3);

  //status color
  static const status_pending_color = Colors.orange;
  static const status_approved_color = const Color(0xFFB0BF7A);
  static const status_rejected_color = Colors.red;

  //shadow
  static const box_shadow = [
    BoxShadow(
        color: Colors.black38,
        offset: Offset(1.5, 1.0), //(x,y)
        blurRadius: 10.0,
        spreadRadius: 2.0),
  ];

  static const tabbar_box_shadow = [
    BoxShadow(
        color: Colors.black12,
        offset: Offset(0.0, -13.0), //(x,y)
        blurRadius: 7.0,
        spreadRadius: -8.0),
  ];
}

// global constants
const kFontSize = 15.0;
const kSmallFontSize = 13.0;
const kFieldFontSize = 18.0;
const kHeadingFontSize = 20.0;
const kTitleFontSize = 25.0;
const kBorderRadius = 40.0;
const kMarginTop = 30.0;

final GlobalKey<ScaffoldState> drawerScaffoldKey =
    new GlobalKey<ScaffoldState>();

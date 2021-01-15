import 'package:flutter/material.dart';

class Constants {
  //font
  static const segoe_font = 'Segoe';
  //asset images
  static const zc_logo = 'assets/zc_logo.png';
  static const zc_logo_notext = 'assets/zc_logo_notext.png';
  static const ic_add_to_cart = 'assets/ic_add_to_cart.png';
  static const ic_delivery = 'assets/ic_delivery.png';
  static const ic_support = 'assets/ic_support.png';
  static const ic_secure = 'assets/ic_secure.png';

  //colors..

  static const zc_orange = const Color(0xFFF76623);
  static const zc_orange_dark = const Color(0xFFF05813);
  static const zc_font_grey = const Color(0xFF666460);
  static const zc_font_light_grey = const Color(0xFFA6A6A6);
  static const zc_white = const Color(0xFFF7F7F7);
  static const zc_yellow = const Color(0xFFFFF2DB);
  static const zc_font_black = const Color(0xFF040505);

  static const vmd_shadow = Color.fromRGBO(38, 41, 55, 0.3);

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
const kFontSize = 16.0;
const kSmallFontSize = 13.0;
const kFieldFontSize = 18.0;
const kHeadingFontSize = 20.0;
const kTitleFontSize = 25.0;
const kBorderRadius = 40.0;
const kMarginTop = 30.0;

final GlobalKey<ScaffoldState> drawerScaffoldKey =
    new GlobalKey<ScaffoldState>();

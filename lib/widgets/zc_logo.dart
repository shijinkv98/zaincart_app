import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';

class ZCLogo extends StatelessWidget {
  ZCLogo({this.size = 240.0});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Constants.zc_logo,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

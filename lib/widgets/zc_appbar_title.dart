import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCAppBarTitle extends StatelessWidget {
  ZCAppBarTitle(
      this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZCText(
        text: title,
        fontSize: 23.0,
        color: Constants.zc_orange_dark,
        semiBold: true,
      ),
    );
  }
}

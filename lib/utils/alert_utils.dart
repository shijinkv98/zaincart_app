import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zaincart_app/utils/constants.dart';

class AlertUtils {
  static showToast(String msg, BuildContext context) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Constants.zc_orange,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
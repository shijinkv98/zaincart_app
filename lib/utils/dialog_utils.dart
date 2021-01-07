import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaincart_app/widgets/vmd_text.dart';


class DialogUtils {
  static showNoNetworkDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new VMDText(
              text: "No internet available",
            ),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: new VMDText(
                    text: "Close",
                  )),
            ],
          );
        });
  }
}

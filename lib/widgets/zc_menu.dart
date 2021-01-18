import 'package:flutter/material.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new Container(
        child: SingleChildScrollView(
          child: Column(children: [
            ZCText(
              text: "Categories",
            ),
            ZCText(
              text: "Categories",
            ),
            ZCText(
              text: "Categories",
            ),
            ZCText(
              text: "Categories",
            ),
            ZCText(
              text: "Categories",
            )
          ],),
        ),
      ),
    );
  }
}

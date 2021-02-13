import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAddressScreenState();
  }
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ZCText(
          text: "MY ADDRESS",
          fontSize: 23.0,
          color: Constants.zc_orange_dark,
          semiBold: true,
        ),
        backgroundColor: Colors.white,
        leading: Builder(
            builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Constants.zc_font_black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ZCText(
                  text: "Contact",
                ),
                ZCText(
                  text: "Edit",
                )
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 100.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZCText(
                      text: "Raghav PK",
                    ),
                    ZCText(
                      text: "Raghavpk@gmail.com",
                    ),
                    ZCText(
                      text: "970088922737823",
                    ),
                  ],
                )
              ],
            ),
            Divider(thickness: 1.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZCText(
                      text: "Shipping Address",
                      semiBold: true,
                    ),
                    SizedBox(height: 5.0,),
                ZCText(
                      text: "Raghav PK",
                    ),
                    ZCText(
                      text: "Raghavpk@gmail.com",
                    ),
                    ZCText(
                      text: "970088922737823",
                    ),
              ],
            ),
            Divider(thickness: 1.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZCText(
                      text: "Billing Address",
                      semiBold: true,
                    ),
                    SizedBox(height: 5.0,),
                ZCText(
                      text: "Raghav PK",
                    ),
                    ZCText(
                      text: "Raghavpk@gmail.com",
                    ),
                    ZCText(
                      text: "970088922737823",
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

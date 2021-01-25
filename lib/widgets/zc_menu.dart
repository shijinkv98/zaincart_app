import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                  color: Constants.zc_orange,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35))),
                      child: Center(child: ZCText(text: "MENU", color: Colors.white, semiBold: true,),),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.ac_unit, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Categories", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.local_offer_sharp, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Offers", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.notification_important, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Notification", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_box_outlined, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"About", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.call, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Contact", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.format_quote, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Faq", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.security, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Terms", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(Icons.policy, color: Constants.zc_font_light_grey,),
                        SizedBox(width: 8.0,),
                        ZCText(text:"Policies", color: Constants.zc_font_grey,),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Constants.zc_font_light_grey,)
                ],
              ),
            )
          ],
        ),
      );
  }
}

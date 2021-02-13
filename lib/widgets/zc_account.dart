import 'package:flutter/material.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/screen/register_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCAccount extends StatelessWidget {
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
            child: Center(
              child: ZCText(
                text: "ACCOUNT",
                color: Colors.white,
                semiBold: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_user,
                          color: Constants.zc_font_light_grey,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Sign in",
                          color: Constants.zc_font_grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => SignUpScreen()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          color: Constants.zc_font_light_grey,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Register",
                          color: Constants.zc_font_grey,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Wishlist",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Checkout",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "My Order",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Rate the App",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.history_edu_outlined,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Clear History",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.policy_sharp,
                        color: Constants.zc_font_light_grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "My Address",
                        color: Constants.zc_font_grey,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Constants.zc_font_light_grey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

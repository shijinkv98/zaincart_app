import 'package:flutter/material.dart';
import 'package:zaincart_app/screen/menu/about_us_screen.dart';
import 'package:zaincart_app/screen/menu/contact_screen.dart';
import 'package:zaincart_app/screen/menu/policy_screen.dart';
import 'package:zaincart_app/screen/menu/terms_conditions_screen.dart';
import 'package:zaincart_app/screen/product_search_screen.dart';
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
            child: Center(
              child: ZCText(
                text: "MENU",
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ProductSearchScreen()));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Constants.ic_category,
                          scale: 7.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Categories",
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
                      Image.asset(
                        Constants.ic_offer,
                        scale: 7.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Offers",
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
                      Image.asset(
                        Constants.ic_notification,
                        scale: 7.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ZCText(
                        text: "Notification",
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
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AboutUsScreen()));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Constants.ic_about,
                          scale: 7.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "About",
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ContactDetailScreen()));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Constants.ic_contact,
                          scale: 7.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Contact",
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
                // Padding(
                //   padding:
                //       const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                //   child: Row(
                //     children: [
                //       Image.asset(
                //         Constants.ic_faq,
                //         scale: 7.0,
                //       ),
                //       SizedBox(
                //         width: 8.0,
                //       ),
                //       ZCText(
                //         text: "Faq",
                //         color: Constants.zc_font_grey,
                //       ),
                //     ],
                //   ),
                // ),
                // Divider(
                //   thickness: 0.5,
                //   color: Constants.zc_font_light_grey,
                // ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TermsAndConditionsScreen()));
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          Constants.ic_terms,
                          scale: 7.0,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Terms",
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
                  child: InkWell( onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PolicyScreen()));
                  },
                                      child: Row(
                      children: [
                        Icon(
                          Icons.policy,
                          color: Constants.zc_font_light_grey,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        ZCText(
                          text: "Policies",
                          color: Constants.zc_font_grey,
                        ),
                      ],
                    ),
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

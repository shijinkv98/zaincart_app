import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaincart_app/blocs/profile_bloc.dart';
import 'package:zaincart_app/screen/login_screen.dart';
import 'package:zaincart_app/screen/account/my_address_screen.dart';
import 'package:zaincart_app/screen/account/my_orders_screen.dart';
import 'package:zaincart_app/screen/my_cart_screen.dart';
import 'package:zaincart_app/screen/register_screen.dart';
import 'package:zaincart_app/screen/wishlist_screen.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/utils/preferences.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileBloc>(context, listen: false).getUserInfo();
    return Drawer(
      child: Consumer<ProfileBloc>(
          builder: (context, profileBloc, child) => ListView(
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
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: !profileBloc.isGuest
                                ? () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginScreen()));
                                  }
                                : () {
                                    Provider.of<ProfileBloc>(context,
                                            listen: false)
                                        .logout(context);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginScreen()));
                                  },
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_signin,
                                  scale: 7.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                ZCText(
                                  text: !profileBloc.isGuest
                                      ? "Sign In"
                                      : "Signout",
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
                        !profileBloc.isGuest
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, top: 5.0, bottom: 5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        SignUpScreen()));
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            Constants.ic_register,
                                            scale: 7.0,
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
                                ],
                              )
                            : new Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      WishlistScreen(
                                        isEnableBack: true,
                                      )));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_wishlist,
                                  scale: 7.0,
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
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Constants.zc_font_light_grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyCartScreen(
                                        enableBack: true,
                                      )));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_checkout,
                                  scale: 7.0,
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
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Constants.zc_font_light_grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyOrdersScreen()));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_myorder,
                                  scale: 7.0,
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
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Constants.zc_font_light_grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: Row(
                            children: [
                              Image.asset(
                                Constants.ic_rate_app,
                                scale: 7.0,
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
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                        //   child: Row(
                        //     children: [
                        //       Image.asset(
                        //         Constants.ic_history,
                        //         scale: 7.0,
                        //       ),
                        //       SizedBox(
                        //         width: 8.0,
                        //       ),
                        //       ZCText(
                        //         text: "Clear History",
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
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5.0, bottom: 5.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyAddressScreen()));
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  Constants.ic_address,
                                  scale: 7.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                ZCText(
                                  text: "My Account",
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
              )),
    );
  }

  Future<bool> isGuestUser() async {
    var result = await Preferences.getBool(PrefKey.loginStatus);
    return result;
  }
}

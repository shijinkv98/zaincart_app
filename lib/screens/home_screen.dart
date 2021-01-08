import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/products_list.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                color: Colors.green,
              ),
              Container(
                height: 220.0,
                decoration: BoxDecoration(
                    color: Constants.zc_orange,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Container(
                        height: 35.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    new ZCText(
                      text: "WHAT ARE YOU LOOKING FOR?",
                      color: Colors.white,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ProductsList(
                title: "LATEST PRODUCTS",
              ),
              SizedBox(
                height: 10,
              ),
              ProductsList(
                title: "NEW PRODUCTS",
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: new Container(
                  width: divWidth,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: new Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new ZCText(
                            text: "REFER A FRIEND",
                            semiBold: true,
                            fontSize: 18.0,
                            color: Constants.zc_orange,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Constants.zc_orange,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35),
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35),
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new ZCText(
                                  text: "Refer Now",
                                  semiBold: true,
                                  color: Colors.white,
                                  fontSize: kSmallFontSize,
                                ),
                              )),
                        ],
                      ),
                      Container(
                        height: 80.0,
                        width: 190.0,
                        child: Image.network(
                          "https://thumbs.dreamstime.com/b/refer-friend-concept-social-media-refer-friend-concept-social-media-businessman-using-mobile-phone-app-to-refer-176615312.jpg",
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ProductsList(
                title: "FEATURED PRODUCTS",
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: new Container(
                  width: divWidth,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      )),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.security,
                              color: Constants.zc_orange,
                              size: 45.0,
                            ),
                            SizedBox(height: 10.0),
                            new ZCText(
                              text: "100% Secure\nPayments",
                              semiBold: true,
                              color: Colors.black,
                              fontSize: 13.0,
                            ),
                            new ZCText(
                              text:
                                  "Lorem Ipsum place holder text will come here",
                              semiBold: false,
                              maxLines: 5,
                              fontSize: 11.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.speed_rounded,
                              color: Constants.zc_orange,
                              size: 45.0,
                            ),
                            SizedBox(height: 10.0),
                            new ZCText(
                              text: "Speed Delivery",
                              semiBold: true,
                              color: Colors.black,
                              fontSize: 13.0,
                            ),
                            new ZCText(
                              text:
                                  "Lorem Ipsum place holder text will come here",
                              semiBold: false,
                              maxLines: 5,
                              fontSize: 11.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone_callback_rounded,
                              color: Constants.zc_orange,
                              size: 45.0,
                            ),
                            SizedBox(height: 10.0),
                            new ZCText(
                              text: "24x7 Support",
                              semiBold: true,
                              color: Colors.black,
                              fontSize: 13.0,
                            ),
                            new ZCText(
                              text:
                                  "Lorem Ipsum place holder text will come here",
                              semiBold: false,
                              maxLines: 5,
                              fontSize: 11.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

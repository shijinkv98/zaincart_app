import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/products_list.dart';
import 'package:zaincart_app/widgets/zc_logo.dart';
import 'package:zaincart_app/widgets/zc_search_field.dart';
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
      appBar: AppBar(
        title: ZCLogo(),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ProgressHUD(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 150.0,
                  width: divWidth,
                  child: Carousel(
                    dotBgColor: Colors.transparent,
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    images: [
                      NetworkImage(
                          'https://www.thespruceeats.com/thmb/ZnWDXm0VjfY2wy25ocFqZccy5YY=/2164x1217/smart/filters:no_upscale()/freshvegetablesAlexRaths-4c1ea186a88e4fd7b95283eee614600c.jpg'),
                      NetworkImage(
                          'https://d12man5gwydfvl.cloudfront.net/wp-content/uploads/2020/09/Fresh-vegetables-at-the-chiller-940x667.jpg'),
                      NetworkImage(
                          'https://previews.123rf.com/images/serezniy/serezniy1110/serezniy111000508/10817587-fresh-vegetables-in-basket-on-wooden-table-on-green-background.jpg'),
                    ],
                  )),
              Container(
                height: 240.0,
                decoration: BoxDecoration(
                    color: Constants.zc_orange,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new ZCSearchField(
                          hintText: "Search",
                        )),
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
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(children: [
                            Container(
                                height: 80.0,
                                width: 100.0,
                                child: Image.network(
                                  "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png",
                                  fit: BoxFit.contain,
                                )),
                            ZCText(
                              text: "Grocery",
                              color: Colors.white,
                              textAlign: TextAlign.center,
                            )
                          ]),
                        ),
                        Expanded(
                          child: Column(children: [
                            Container(
                                height: 80.0,
                                width: 100.0,
                                child: Image.network(
                                  "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png",
                                  fit: BoxFit.contain,
                                )),
                            ZCText(
                              text: "Fruit & Vegetables",
                              color: Colors.white,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            )
                          ]),
                        ),
                        Expanded(
                          child: Column(children: [
                            Center(
                                child: Container(
                                    height: 80.0,
                                    width: 100.0,
                                    child: Image.network(
                                      "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png",
                                      fit: BoxFit.contain,
                                    ))),
                            Center(
                              child: ZCText(
                                text: "Diary",
                                color: Colors.white,
                              ),
                            )
                          ]),
                        ),
                        Expanded(
                          child: Column(children: [
                            Center(
                                child: Container(
                                    height: 80.0,
                                    width: 100.0,
                                    child: Image.network(
                                      "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png",
                                      fit: BoxFit.contain,
                                    ))),
                            Center(
                              child: ZCText(
                                text: "Meat",
                                color: Colors.white,
                              ),
                            )
                          ]),
                        ),
                      ],
                    )
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

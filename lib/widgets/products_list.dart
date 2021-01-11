import 'package:flutter/material.dart';
import 'package:zaincart_app/screens/product_detail.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ProductsList extends StatelessWidget {
  ProductsList({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205.0,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          new ZCText(
            text: title,
            color: Constants.zc_orange,
            semiBold: true,
          ),
          Container(
            child: Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                        onTap: () => _onItemTap(context),
                        child: new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                            child: Stack(
                              children: [
                                Container(
                                  width: 180,
                                ),
                                Positioned(
                                    left: 10.0,
                                    child: Icon(
                                      Icons.access_alarm,
                                      color: Colors.grey,
                                    )),
                                Positioned(
                                    right: 10.0,
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.grey,
                                    )),
                                Column(
                                  children: [
                                    Center(
                                        child: Container(
                                            height: 80.0,
                                            width: 130.0,
                                            child: Image.network(
                                              "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png",
                                              fit: BoxFit.contain,
                                            ))),
                                    Center(
                                      child: ZCText(
                                        text: "Orange",
                                        color: Constants.zc_orange,
                                      ),
                                    ),
                                    Center(
                                      child: ZCText(
                                        text: "*****",
                                        color: Constants.zc_orange,
                                      ),
                                    ),
                                    Center(
                                      child: ZCText(
                                        text: "INR 37.09",
                                        color: Constants.zc_orange,
                                      ),
                                    ),
                                    Container(
                                      width: 180,
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.orange[100],
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          )),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, right: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(
                                                Icons.shopping_cart_outlined,
                                                color: Colors.grey,
                                              ),
                                              ZCText(
                                                text: "Add to Cart",
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: Constants.zc_orange,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }

  _onItemTap(BuildContext context) {
     Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ProductDetail()));
  }
}

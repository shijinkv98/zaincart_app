import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCartScreenState();
  }
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 14,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext ctxt, int index) {
            return new Padding(
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
                            color: Colors.orange,
                          ),
                        ),
                        Center(
                          child: ZCText(
                            text: "*****",
                            color: Colors.orange,
                          ),
                        ),
                        Center(
                          child: ZCText(
                            text: "INR 37.09",
                            color: Colors.orange,
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
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
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
            );
          }),
    );
  }
}

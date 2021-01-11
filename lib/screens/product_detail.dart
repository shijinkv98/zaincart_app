import 'package:flutter/material.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ProductDetail extends StatefulWidget {
  @override
  ProductDetailState createState() => ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final double divHeight = MediaQuery.of(context).size.height;
    final double divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ZCText(
          text: "GROCERY",
          color: Constants.zc_orange,
          bold: true,
          fontSize: 30.0,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: [
            new Container(
              padding: EdgeInsets.all(10.0),
              child: Image.network(
                  "https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new ZCText(
                      text: "Channa Dal",
                      color: Constants.zc_orange,
                      semiBold: true,
                      fontSize: kTitleFontSize,
                    ),
                    Row(
                      children: [
                        new ZCText(
                          text: "QAR 6.23",
                          color: Colors.grey,
                          semiBold: true,
                          fontSize: kTitleFontSize,
                        ),
                        new ZCText(
                          text: "QAR 6.23",
                          color: Colors.grey,
                          semiBold: true,
                          fontSize: kFontSize,
                        ),
                      ],
                    ),
                    new ZCText(
                      text: "****",
                      color: Constants.zc_orange,
                      semiBold: true,
                      fontSize: kTitleFontSize,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    new ZCText(
                      text: "In stock",
                      color: Colors.green,
                      semiBold: true,
                      fontSize: kFontSize,
                    ),
                    new ZCText(
                      text: "SKU: Chnnna Dal",
                      color: Colors.black54,
                      semiBold: true,
                      fontSize: kTitleFontSize,
                    ),
                    Container(
                      width: 180,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCText(
                      text: "Share this appa",
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCText(
                      text:
                          "Share this appa  da f sdf sd fs df sdfsd f sdf sdfsdfsdfqweqwe aosjnadoasd asd a sd asda da sd as dansdoad as da sd a sdasjdnasndoasdoiasd ",
                      maxLines: 8,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ZCText(
                      text: "Your Rating",
                      fontSize: kHeadingFontSize,
                      color: Constants.zc_orange,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCText(
                      text: "*****",
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ZCText(
                      text: "Rating and Reviews",
                      fontSize: kHeadingFontSize,
                      color: Constants.zc_orange,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ZCText(
                      text:
                          "d asda da sd as dansdoad as da sd a sdasjdnasndoasdoiasd ",
                      maxLines: 8,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

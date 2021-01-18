import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
        leading: Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: [
            Stack(
              children: [
                SizedBox(
                      height: 200.0,
                      width: divWidth,
                      child: Carousel(
                        dotBgColor: Colors.transparent,
                        dotSize: 5.0,
                        dotSpacing: 15.0,
                        images: [
                          NetworkImage(
                              'https://freepngimg.com/thumb/fruit/7-2-fruit-png-hd.png'),
                          NetworkImage(
                              'https://d12man5gwydfvl.cloudfront.net/wp-content/uploads/2020/09/Fresh-vegetables-at-the-chiller-940x667.jpg'),
                          NetworkImage(
                              'https://previews.123rf.com/images/serezniy/serezniy1110/serezniy111000508/10817587-fresh-vegetables-in-basket-on-wooden-table-on-green-background.jpg'),
                        ],
                      )),
                      Positioned(
                  left: 20.0,
                  top: 20.0,
                  child: CircleAvatar(
                    backgroundColor: Constants.zc_orange_dark,
                    radius: 18,
                    child: ZCText(
                      text: "50%",
                      color: Colors.white,
                      fontSize: kSmallFontSize,
                    ),
                  )),
              Positioned(
                  right: 20.0,
                  top: 20.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 18,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.favorite_border_outlined),
                      color: Constants.zc_font_black,
                      onPressed: () {
                        print("Add to faviorate button clicked.....");
                      },
                    ),
                  ))

              ],
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
                      color: Constants.zc_orange_dark,
                      semiBold: true,
                      fontSize: kTitleFontSize,
                    ),
                    Row(
                      children: [
                        new ZCText(
                          text: "QAR 6.23",
                          color: Constants.zc_font_grey,
                          semiBold: true,
                          fontSize: kTitleFontSize,
                        ),
                        SizedBox(width: 10.0,),
                        new ZCText(
                          text: "QAR 6.23",
                          color: Colors.grey,
                          semiBold: true,
                          fontSize: kFontSize,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0,),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      itemSize: 15.0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Constants.zc_orange,
                        size: 15.0,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
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
                      fontSize: kFontSize,
                    ),
                    SizedBox(height:10.0),
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
                            Image.asset(
                              Constants.ic_add_to_cart,
                              height: 23.0,
                              width: 23.0,
                            ),
                            ZCText(
                              text: "Add to Cart",
                              fontSize: kSmallFontSize,
                            ),
                            ZCText(
                              text: "|",
                              fontSize: kFontSize,
                              color: Colors.white,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.add,
                                color: Constants.zc_orange,
                                //size: 10.0,
                              ),
                              onTap: () {
                                print("Add to faviorate button clicked.....");
                              },
                            )
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
                      fontSize: kFontSize,
                      color: Constants.zc_orange,
                      semiBold: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      itemSize: 15.0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Constants.zc_orange,
                        size: 15.0,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ZCText(
                      text: "Rating and Reviews",
                      fontSize: kFontSize,
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

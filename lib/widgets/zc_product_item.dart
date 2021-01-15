import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zaincart_app/screens/product_detail.dart';
import 'package:zaincart_app/utils/constants.dart';
import 'package:zaincart_app/widgets/zc_text.dart';

class ZCProductItem extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onItemTap(context),
      child: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(top: 5.0),
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
                  child: CircleAvatar(
                    backgroundColor: Constants.zc_orange_dark,
                    radius: 12,
                    child: ZCText(
                      text: "5%",
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )),
              Positioned(
                  right: 10.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 10,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.favorite_border_outlined),
                      color: Colors.grey,
                      onPressed: () {
                        print("Add to faviorate button clicked.....");
                      },
                    ),
                  )),
              Column(
                children: [
                  Center(
                      child: Container(
                          //height: 80.0,
                          width: 130.0,
                          margin: EdgeInsets.only(top: 10.0),
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
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      itemSize: 10.0,
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
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: ZCText(
                      text: "QAR 37.09",
                      color: Constants.zc_font_black,
                      semiBold: true,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 180,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: Constants.zc_yellow,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ); 
  }
  
  _onItemTap(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ProductDetail()));
  }
}
